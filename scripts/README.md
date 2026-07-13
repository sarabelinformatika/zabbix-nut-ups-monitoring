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
