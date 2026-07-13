# Configuration Examples

## Overview

This directory contains example configuration files used throughout this project.

These examples are intended as a starting point for deploying **Network UPS Tools (NUT)** together with **Zabbix** on Linux or Proxmox systems.

Every environment is different, therefore you should review and adapt the configuration before deploying it in production.

---

# Included Examples

| File | Description |
|------|-------------|
| nut.conf | NUT operating mode |
| ups.conf | UPS device configuration |
| upsd.conf | NUT server configuration |
| upsd.users | User authentication |
| upsmon.conf | UPS monitoring daemon |
| zabbix_agentd.conf | Zabbix Agent UserParameters |

---

# Production Recommendation

Before copying any configuration into production:

- Review every configuration file.
- Replace example usernames and passwords.
- Verify UPS identifiers.
- Test communication with `upsc`.
- Restart services after every change.
- Perform a complete functionality test.

---

# Disclaimer

These files are provided as reference examples.

Always test your configuration before using it in a production environment.
