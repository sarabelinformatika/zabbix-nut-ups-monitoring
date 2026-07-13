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

# Zabbix NUT UPS Template

Files:

- `zabbix_export.yaml` — canonical Zabbix 7.0 template export.
- `zabbix_export.xml` — XML representation of the same template.

The template requires:

- `ups.discovery`
- `ups.status[*]`
- `ups.charge[*]`
- `ups.runtime[*]`
- `ups.load[*]`
- `ups.input[*]`
- `ups.output[*]`
- `ups.battery[*]`
- `ups.temperature[*]`
- `ups.model[*]`
- `ups.manufacturer[*]`
- `ups.driver[*]`

Import into a test Zabbix 7.0 instance first. The YAML file is the recommended canonical source because it is easier to review and maintain.
