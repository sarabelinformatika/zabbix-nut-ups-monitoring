# Zabbix Template

## Overview

This directory contains the Zabbix template and UserParameter configuration required to monitor USB-connected UPS devices using **Network UPS Tools (NUT)**.

The template has been designed to work with:

- Linux
- Proxmox VE
- Zabbix 6.x LTS
- Zabbix 7.x

---

# Included Files

| File | Description |
|------|-------------|
| zabbix_export.xml | Importable Zabbix template |
| userparameters.conf | Zabbix Agent UserParameters |

---

# Importing the Template

Import the template using:

```
Data Collection
    ↓
Templates
    ↓
Import
```

After importing, link the template to the monitoring host.

---

# Installing UserParameters

Copy the configuration.

```bash
cp userparameters.conf \
/etc/zabbix/zabbix_agentd.d/
```

Restart the agent.

```bash
systemctl restart zabbix-agent
```

---

# Verify

Example:

```bash
zabbix_agentd -t ups.status[ups_network]
```

Expected output:

```
OL
```

---

# Supported Metrics

The template monitors:

- UPS Status
- Battery Charge
- Battery Runtime
- UPS Load
- Input Voltage
- Output Voltage
- Battery Voltage
- Battery Temperature
- UPS Model
- UPS Manufacturer
- Driver Information

---

# Multiple UPS Support

The template supports monitoring multiple UPS devices using generic UserParameters.

Example:

```
ups_network

ups_servers

ups_workstations
```

No template modifications are required.

---

# Compatibility

| Component | Supported |
|-----------|-----------|
| Zabbix 6.x | ✅ |
| Zabbix 7.x | ✅ |
| NUT | ✅ |
| Linux | ✅ |
| Proxmox VE | ✅ |

---

For detailed installation instructions, see the documentation in the **docs/** directory.
