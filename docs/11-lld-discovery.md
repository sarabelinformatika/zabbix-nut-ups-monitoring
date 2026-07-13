# Low Level Discovery (LLD)

## Overview

Low Level Discovery (LLD) is one of the most powerful features of Zabbix.

Instead of manually creating items, triggers, and graphs for every UPS, Zabbix can automatically discover available UPS devices and generate all monitoring objects dynamically.

This approach greatly simplifies administration, especially in environments where UPS devices are added, replaced, or removed over time.

---

# Why Use Low Level Discovery?

Traditional monitoring requires administrators to:

- Create every Item manually
- Create every Trigger manually
- Create every Graph manually
- Update configurations whenever infrastructure changes

Low Level Discovery automates the entire process.

Benefits include:

- Automatic device discovery
- Reduced administration
- Consistent monitoring
- Easier scalability
- Faster deployment
- Simplified maintenance

---

# Discovery Workflow

```text
USB UPS
     │
     ▼
Network UPS Tools (NUT)
     │
     ▼
Discovery Script
     │
     ▼
JSON Output
     │
     ▼
Zabbix LLD Rule
     │
     ▼
Items
Triggers
Graphs
```

---

# How It Works

The discovery process consists of four stages:

1. NUT detects connected UPS devices.
2. A discovery script generates JSON output.
3. Zabbix imports the JSON.
4. Item prototypes automatically create monitoring objects.

No manual configuration is required after discovery.

---

# Discovery Script

A discovery script queries Network UPS Tools.

Example:

```bash
upsc -l
```

Example output:

```text
ups_network
ups_servers
ups_workstations
```

The script converts this information into Zabbix-compatible JSON.

---

# Example JSON

Example discovery output:

```json
{
    "data": [
        {
            "{#UPS}": "ups_network"
        },
        {
            "{#UPS}": "ups_servers"
        },
        {
            "{#UPS}": "ups_workstations"
        }
    ]
}
```

Each discovered UPS becomes a separate monitoring instance.

---

# Discovery Rule

Example discovery rule:

| Setting | Value |
|---------|-------|
| Type | Zabbix Agent |
| Key | ups.discovery |
| Update Interval | 1 hour |

Running discovery every hour is sufficient for most environments.

---

# Item Prototypes

Each discovered UPS automatically receives monitoring items.

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

No manual item creation is required.

---

# Trigger Prototypes

Triggers are also generated automatically.

Examples include:

- UPS Running on Battery
- Battery Charge Low
- Runtime Critical
- UPS Communication Lost
- UPS Overload
- Replace Battery

Every discovered UPS receives identical trigger logic.

---

# Graph Prototypes

Graphs can also be created automatically.

Recommended graphs:

- Battery Charge
- Runtime
- UPS Load
- Input Voltage
- Output Voltage

Each UPS receives its own graph set.

---

# Discovery Frequency

Recommended discovery intervals:

| Environment | Interval |
|-------------|----------|
| Home Lab | 24 hours |
| Small Office | 6 hours |
| Enterprise | 1 hour |

UPS hardware changes infrequently, so aggressive discovery intervals are usually unnecessary.

---

# Removing Devices

If a UPS is disconnected permanently:

- Discovery no longer detects it.
- Zabbix can automatically remove the associated items.
- Historical data remains available according to housekeeping settings.

This keeps the monitoring configuration clean.

---

# Advantages

Using Low Level Discovery provides:

- Automatic scaling
- Reduced manual work
- Consistent naming
- Faster deployment
- Easier maintenance
- Better long-term manageability

---

# When LLD May Not Be Necessary

For very small environments:

- One UPS
- Static infrastructure
- No planned expansion

Manual item creation may be perfectly adequate.

LLD becomes increasingly valuable as the number of monitored UPS devices grows.

---

# Best Practices

For production environments:

- Use descriptive UPS identifiers.
- Keep discovery intervals reasonable.
- Test discovery after infrastructure changes.
- Monitor discovery execution.
- Document custom discovery rules.
- Keep discovery scripts under version control.

---

# Summary

Low Level Discovery allows Zabbix to automatically build and maintain the monitoring configuration for all detected UPS devices.

Combined with Network UPS Tools and generic UserParameters, LLD provides a scalable, enterprise-ready monitoring solution that minimizes administrative effort while maintaining complete visibility into UPS infrastructure.

---

**Previous:** [← Triggers](10-triggers.md)

**Next:** [Proxmox Integration →](12-proxmox-integration.md)
