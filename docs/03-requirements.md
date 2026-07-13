# Requirements

## Overview

Before deploying this monitoring solution, ensure that your environment meets the minimum software and hardware requirements.

The project is designed to be lightweight and compatible with most modern Linux distributions while providing enterprise-grade monitoring capabilities through **Network UPS Tools (NUT)** and **Zabbix**.

---

# Supported Operating Systems

The following operating systems have been tested or are officially supported.

| Operating System | Supported |
|------------------|-----------|
| Debian 12 | ✅ |
| Debian 13 | ✅ |
| Ubuntu Server 22.04 LTS | ✅ |
| Ubuntu Server 24.04 LTS | ✅ |
| Proxmox VE 8.x | ✅ |

Other Linux distributions may work but are not officially tested.

---

# Supported Zabbix Versions

This project supports:

| Version | Supported |
|----------|-----------|
| Zabbix 6.x LTS | ✅ |
| Zabbix 7.x | ✅ |

Older versions may require manual template modifications.

---

# Supported Network UPS Tools Versions

Recommended versions:

| NUT Version | Supported |
|--------------|-----------|
| 2.8.x | ✅ |
| Newer stable releases | ✅ |

Always use the latest stable version available in your Linux distribution.

---

# Supported UPS Devices

This project is designed for **USB HID-compatible UPS devices** supported by Network UPS Tools.

Examples include:

- APC
- Eaton
- CyberPower
- NJOY
- PowerWalker
- Mustek
- Riello
- Salicru
- Vertiv
- Other HID-compatible UPS devices

Support ultimately depends on the available NUT driver.

---

# Hardware Requirements

Minimum requirements:

| Component | Recommendation |
|-----------|----------------|
| CPU | 1 Core |
| Memory | 512 MB RAM |
| Storage | 1 GB free space |
| USB Ports | One per UPS device |
| Network | Ethernet connection |

The monitoring solution has very low resource requirements.

---

# Required Software Packages

The following packages are required:

- Network UPS Tools
- Zabbix Agent
- USB HID drivers
- Systemd

Depending on your Linux distribution, package names may vary slightly.

---

# USB Requirements

UPS devices should be connected directly to the Linux or Proxmox host using USB.

Recommended:

- USB 2.0 or newer
- High-quality USB cables
- Stable USB ports
- Avoid unpowered USB hubs

Reliable USB communication is essential for accurate monitoring.

---

# Network Requirements

The monitoring host must be able to communicate with the Zabbix Server.

Typical requirements include:

- TCP connectivity
- DNS resolution (optional)
- Stable network connection

No internet access is required for normal operation.

---

# User Permissions

Installation requires administrative privileges.

Recommended user:

```text
root
```

or a user with:

- sudo privileges
- permission to manage system services
- access to USB devices

---

# Firewall Requirements

Ensure that the Zabbix Agent port is accessible from the Zabbix Server.

Typical ports include:

| Service | Port |
|----------|------|
| Zabbix Agent | 10050 |
| Zabbix Server | 10051 |

If using active checks, verify outbound connectivity to the Zabbix Server.

---

# Time Synchronization

Accurate timestamps are important for monitoring and alerting.

Recommended:

- systemd-timesyncd
- Chrony
- NTP

Time synchronization ensures correct event correlation and graph accuracy.

---

# Recommended Environment

For production deployments, the following environment is recommended:

- Debian or Proxmox VE
- Latest stable NUT release
- Latest supported Zabbix LTS version
- USB HID-compatible UPS devices
- Dedicated monitoring server
- Centralized dashboards
- Regular backups

---

# Before You Continue

Before proceeding, verify that:

- Linux is installed and updated.
- Zabbix Server is operational.
- Zabbix Agent is installed.
- The UPS is connected via USB.
- The UPS is recognized by the operating system.
- Administrative access is available.

Completing these checks will ensure a smooth installation process.

---

**Previous:** [← Architecture](02-architecture.md)

**Next:** [Installation →](04-installation.md)
