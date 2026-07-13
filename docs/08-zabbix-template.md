# Zabbix Template

## Overview

This repository includes a ready-to-import Zabbix template designed specifically for monitoring USB-connected UPS devices using **Network UPS Tools (NUT)**.

The template provides a standardized monitoring solution that minimizes manual configuration while following Zabbix best practices.

Once imported, administrators can immediately begin collecting UPS metrics from Linux or Proxmox hosts running the Zabbix Agent.

---

# Template Goals

The template has been designed to provide:

- Enterprise-ready monitoring
- Vendor-independent UPS support
- Easy deployment
- Simple maintenance
- Scalable architecture
- Native Zabbix integration

---

# Importing the Template

The template is located in:

```text
templates/zabbix_export.xml
```

Import it using:

```text
Data Collection
    ↓
Templates
    ↓
Import
```

After importing, link the template to the monitoring host.

---

# Template Structure

The template contains:

- Items
- Triggers
- Graphs
- Value Maps
- Macros
- Discovery Rules (optional)
- Tags

The goal is to provide a complete monitoring solution without requiring manual item creation.

---

# Collected Metrics

The template collects the following UPS information.

| Metric | Description |
|----------|-------------|
| UPS Status | Current UPS state |
| Battery Charge | Remaining battery capacity |
| Battery Runtime | Estimated runtime |
| UPS Load | Current load percentage |
| Input Voltage | Incoming utility voltage |
| Output Voltage | UPS output voltage |
| Battery Voltage | Current battery voltage |
| Battery Temperature | Battery temperature (if supported) |
| Device Model | UPS model |
| Manufacturer | UPS vendor |
| Driver | Active NUT driver |

Some values depend on UPS capabilities and driver support.

---

# Item Keys

The template uses generic UserParameters.

Examples:

```text
ups.status[{#UPS}]

ups.charge[{#UPS}]

ups.runtime[{#UPS}]

ups.load[{#UPS}]

ups.input[{#UPS}]

ups.output[{#UPS}]

ups.battery[{#UPS}]

ups.temperature[{#UPS}]
```

These keys allow the same template to monitor any supported UPS.

---

# Value Maps

The template includes value maps for common UPS states.

Example:

| Value | Meaning |
|--------|----------|
| OL | Online |
| OB | On Battery |
| LB | Low Battery |
| CHRG | Charging |
| DISCHRG | Discharging |
| RB | Replace Battery |

Using value maps improves dashboard readability.

---

# Trigger Design

The template includes recommended production triggers.

Examples include:

- UPS on Battery
- Battery Charge Low
- Battery Runtime Critical
- UPS Communication Lost
- UPS Overloaded
- Replace Battery
- Input Voltage Problem

Thresholds can be adjusted to match local requirements.

---

# Graphs

The template automatically generates graphs for:

- Battery Charge
- Battery Runtime
- UPS Load
- Input Voltage
- Output Voltage
- Battery Voltage

These graphs provide long-term visibility into UPS health.

---

# Macros

The template supports configurable thresholds through macros.

Example:

| Macro | Description |
|--------|-------------|
| {$UPS.BATTERY.LOW} | Low battery threshold |
| {$UPS.RUNTIME.MIN} | Minimum runtime |
| {$UPS.LOAD.MAX} | Maximum recommended load |

Using macros allows the same template to be reused across multiple environments.

---

# Multiple UPS Support

The template is designed to work with multiple UPS devices.

Example:

```text
ups_network

ups_servers

ups_workstations
```

Each UPS is monitored independently while using the same template.

No template duplication is required.

---

# Host Assignment

The template can be linked to:

- Linux servers
- Proxmox hosts
- Dedicated monitoring servers

Alternatively, each UPS can be represented as an individual logical host inside Zabbix while still using a single Zabbix Agent.

---

# Recommended Update Interval

Suggested polling intervals:

| Metric | Interval |
|----------|----------|
| UPS Status | 30 seconds |
| Battery Charge | 60 seconds |
| Runtime | 60 seconds |
| UPS Load | 60 seconds |
| Voltage | 60 seconds |
| Device Information | 1 hour |

These values provide excellent visibility without creating unnecessary monitoring overhead.

---

# Customization

The template has been intentionally designed to be easy to customize.

Administrators may:

- Add new metrics
- Modify polling intervals
- Create additional graphs
- Add custom triggers
- Extend discovery rules

No changes to the NUT configuration are required.

---

# Best Practices

For production environments:

- Use descriptive UPS names.
- Keep template versions synchronized.
- Document custom modifications.
- Test trigger thresholds.
- Review graphs regularly.
- Update templates after major Zabbix upgrades.

---

# Summary

The included Zabbix Template provides a complete monitoring solution for Network UPS Tools.

Combined with the supplied UserParameters and documentation, it enables rapid deployment while remaining flexible enough for enterprise environments.

---

**Previous:** [← Zabbix Agent Integration](07-zabbix-agent.md)

**Next:** [UserParameters →](09-userparameters.md)
