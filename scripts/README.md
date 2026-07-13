# Scripts

## Overview

This directory contains helper scripts used throughout the project.

The scripts are intended to simplify deployment, verification, and maintenance of Network UPS Tools (NUT) and Zabbix monitoring.

All scripts have been written for Linux environments including Debian, Ubuntu Server, and Proxmox VE.

---

# Included Scripts

| Script | Description |
|---------|-------------|
| install.sh | Basic installation helper |
| check_nut.sh | Verify NUT configuration |
| discover_ups.sh | Discover connected UPS devices |
| nut-healthcheck.sh | Perform a complete UPS health check |

---

## Requirements

- Bash
- Network UPS Tools (NUT)
- Zabbix Agent
- Root or sudo privileges

---

## Usage

Make scripts executable.

```bash
chmod +x *.sh
```

Run a script.

```bash
./script_name.sh
```

---

## Disclaimer

Always review scripts before running them in production environments.

# proxmox-shutdown.sh

Gracefully shuts down Proxmox Virtual Environment when the configured UPS runtime threshold has been reached.

## Installation

Copy the script:

```bash
install -m 750 \
    proxmox-shutdown.sh \
    /usr/local/sbin/proxmox-shutdown.sh
```

## Test Mode

The script supports a dry-run mode for safe testing.

```bash
DRY_RUN=true \
UPS_NAME=ups_servers \
RUNTIME_THRESHOLD=999999 \
/usr/local/sbin/proxmox-shutdown.sh
```

The high runtime threshold forces the shutdown logic to execute while `DRY_RUN=true` prevents any virtual machines, containers, or the host from being powered off.

## Production Example

```bash
UPS_NAME=ups_servers \
RUNTIME_THRESHOLD=300 \
/usr/local/sbin/proxmox-shutdown.sh
```

The script will initiate a graceful shutdown when the estimated UPS runtime reaches five minutes.

## Multiple UPS Deployments

Only the UPS protecting the Proxmox host should control the automatic shutdown procedure.

For example:

- `ups_servers` → Controls the Proxmox shutdown process.
- `ups_network` → Used only for monitoring network equipment.
- `ups_workstations` → Used only for monitoring office workstations.

This prevents unrelated UPS events from shutting down the virtualization host.
