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
