#!/usr/bin/env bash

###############################################################################
# proxmox-shutdown.sh
#
# Graceful Proxmox VE shutdown based on Network UPS Tools (NUT) data.
#
# Repository:
# https://github.com/sarabelinformatika/zabbix-nut-ups-monitoring
#
# WARNING:
# Test this script in a controlled environment before production use.
###############################################################################

set -Eeuo pipefail

###############################################################################
# Configuration
###############################################################################

# NUT UPS identifier as shown by:
# upsc -l
UPS_NAME="${UPS_NAME:-ups_servers}"

# NUT server address.
NUT_HOST="${NUT_HOST:-localhost}"

# Begin shutdown when estimated runtime is equal to or below this value.
# Value is specified in seconds.
RUNTIME_THRESHOLD="${RUNTIME_THRESHOLD:-300}"

# Maximum time allowed for graceful VM and container shutdown.
SHUTDOWN_TIMEOUT="${SHUTDOWN_TIMEOUT:-180}"

# Delay between shutdown status checks.
CHECK_INTERVAL="${CHECK_INTERVAL:-5}"

# Optional delay before the Proxmox host powers off.
HOST_SHUTDOWN_DELAY="${HOST_SHUTDOWN_DELAY:-10}"

# Force-stop remaining guests after the graceful shutdown timeout.
# Set to "true" only after carefully evaluating the risk.
FORCE_STOP="${FORCE_STOP:-false}"

# Set to "true" for testing. No shutdown commands will be executed.
DRY_RUN="${DRY_RUN:-false}"

LOCK_FILE="/run/lock/proxmox-ups-shutdown.lock"
LOG_TAG="proxmox-ups-shutdown"

###############################################################################
# Logging
###############################################################################

log() {
    local message="$1"

    printf '%s [%s] %s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" \
        "$LOG_TAG" \
        "$message"

    logger -t "$LOG_TAG" -- "$message" 2>/dev/null || true
}

fail() {
    log "ERROR: $1"
    exit 1
}

run_command() {
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY-RUN: $*"
    else
        "$@"
    fi
}

###############################################################################
# Validation
###############################################################################

if [[ "${EUID}" -ne 0 ]]; then
    fail "This script must be executed as root."
fi

for command in upsc qm pct systemctl awk flock; do
    command -v "$command" >/dev/null 2>&1 \
        || fail "Required command not found: $command"
done

if ! [[ "$RUNTIME_THRESHOLD" =~ ^[0-9]+$ ]]; then
    fail "RUNTIME_THRESHOLD must be a positive integer."
fi

if ! [[ "$SHUTDOWN_TIMEOUT" =~ ^[0-9]+$ ]]; then
    fail "SHUTDOWN_TIMEOUT must be a positive integer."
fi

if ! [[ "$CHECK_INTERVAL" =~ ^[0-9]+$ ]]; then
    fail "CHECK_INTERVAL must be a positive integer."
fi

###############################################################################
# Locking
###############################################################################

mkdir -p "$(dirname "$LOCK_FILE")"

exec 9>"$LOCK_FILE"

if ! flock -n 9; then
    fail "Another shutdown process is already running."
fi

###############################################################################
# NUT functions
###############################################################################

nut_target="${UPS_NAME}@${NUT_HOST}"

get_nut_value() {
    local variable="$1"

    upsc "$nut_target" "$variable" 2>/dev/null \
        | tr -d '\r' \
        | awk '{$1=$1; print}'
}

get_ups_status() {
    get_nut_value "ups.status"
}

get_battery_runtime() {
    get_nut_value "battery.runtime"
}

get_battery_charge() {
    get_nut_value "battery.charge"
}

###############################################################################
# Proxmox guest functions
###############################################################################

get_running_vms() {
    qm list 2>/dev/null \
        | awk 'NR > 1 && $3 == "running" {print $1}'
}

get_running_containers() {
    pct list 2>/dev/null \
        | awk 'NR > 1 && $2 == "running" {print $1}'
}

shutdown_vms() {
    local vmid

    while read -r vmid; do
        [[ -z "$vmid" ]] && continue

        log "Requesting graceful shutdown of VM ${vmid}."
        run_command qm shutdown "$vmid" --timeout "$SHUTDOWN_TIMEOUT" &
    done < <(get_running_vms)

    wait || true
}

shutdown_containers() {
    local ctid

    while read -r ctid; do
        [[ -z "$ctid" ]] && continue

        log "Requesting graceful shutdown of container ${ctid}."
        run_command pct shutdown "$ctid" --timeout "$SHUTDOWN_TIMEOUT" &
    done < <(get_running_containers)

    wait || true
}

wait_for_guests() {
    local deadline
    local running_vms
    local running_containers

    deadline=$((SECONDS + SHUTDOWN_TIMEOUT))

    while (( SECONDS < deadline )); do
        running_vms="$(get_running_vms || true)"
        running_containers="$(get_running_containers || true)"

        if [[ -z "$running_vms" && -z "$running_containers" ]]; then
            log "All virtual machines and containers have stopped."
            return 0
        fi

        log "Waiting for remaining guests to stop."

        if [[ -n "$running_vms" ]]; then
            log "Running VMs: $(echo "$running_vms" | xargs)"
        fi

        if [[ -n "$running_containers" ]]; then
            log "Running containers: $(echo "$running_containers" | xargs)"
        fi

        sleep "$CHECK_INTERVAL"
    done

    return 1
}

force_stop_remaining_guests() {
    local vmid
    local ctid

    if [[ "$FORCE_STOP" != "true" ]]; then
        log "Force-stop is disabled. Remaining guests will not be forcibly stopped."
        return 0
    fi

    while read -r vmid; do
        [[ -z "$vmid" ]] && continue

        log "Force-stopping VM ${vmid}."
        run_command qm stop "$vmid"
    done < <(get_running_vms)

    while read -r ctid; do
        [[ -z "$ctid" ]] && continue

        log "Force-stopping container ${ctid}."
        run_command pct stop "$ctid"
    done < <(get_running_containers)
}

###############################################################################
# Shutdown decision
###############################################################################

log "Checking UPS ${nut_target}."

if ! UPS_STATUS="$(get_ups_status)"; then
    fail "Unable to retrieve UPS status from NUT."
fi

BATTERY_RUNTIME="$(get_battery_runtime || true)"
BATTERY_CHARGE="$(get_battery_charge || true)"

log "UPS status: ${UPS_STATUS}"
log "Battery charge: ${BATTERY_CHARGE:-unknown}%"
log "Estimated runtime: ${BATTERY_RUNTIME:-unknown} seconds"

# Do not shut down while utility power is available.
if [[ "$UPS_STATUS" == *"OL"* && "$UPS_STATUS" != *"OB"* ]]; then
    log "UPS is online. Shutdown is not required."
    exit 0
fi

# The UPS must be on battery or report a low-battery condition.
if [[ "$UPS_STATUS" != *"OB"* && "$UPS_STATUS" != *"LB"* ]]; then
    log "UPS is not reporting an actionable battery state."
    exit 0
fi

SHUTDOWN_REQUIRED="false"
SHUTDOWN_REASON=""

if [[ "$UPS_STATUS" == *"LB"* ]]; then
    SHUTDOWN_REQUIRED="true"
    SHUTDOWN_REASON="UPS reports a low-battery condition"
elif [[ "$BATTERY_RUNTIME" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    runtime_integer="${BATTERY_RUNTIME%.*}"

    if (( runtime_integer <= RUNTIME_THRESHOLD )); then
        SHUTDOWN_REQUIRED="true"
        SHUTDOWN_REASON="estimated runtime is ${runtime_integer} seconds"
    fi
else
    log "Battery runtime is unavailable or invalid. No runtime-based shutdown will occur."
fi

if [[ "$SHUTDOWN_REQUIRED" != "true" ]]; then
    log "Shutdown threshold has not been reached."
    exit 0
fi

###############################################################################
# Shutdown procedure
###############################################################################

log "Controlled shutdown initiated: ${SHUTDOWN_REASON}."
log "Configured runtime threshold: ${RUNTIME_THRESHOLD} seconds."

shutdown_vms
shutdown_containers

if ! wait_for_guests; then
    log "Graceful guest shutdown timeout reached."
    force_stop_remaining_guests
fi

if [[ "$DRY_RUN" == "true" ]]; then
    log "DRY-RUN: Proxmox host would now power off."
    exit 0
fi

log "Proxmox host will power off in ${HOST_SHUTDOWN_DELAY} seconds."
sleep "$HOST_SHUTDOWN_DELAY"

sync
log "Powering off Proxmox host."

systemctl poweroff
