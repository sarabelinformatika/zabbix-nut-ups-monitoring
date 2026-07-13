# UserParameters

## Overview

Zabbix UserParameters provide a simple and flexible way to expose custom metrics collected by **Network UPS Tools (NUT)**.

Instead of developing custom scripts or external applications, the Zabbix Agent executes local `upsc` commands and returns the requested values directly to the Zabbix Server.

This approach offers excellent performance while remaining lightweight and easy to maintain.

---

# Why UserParameters?

Using UserParameters provides several advantages.

- Native Zabbix functionality
- No external scripts required
- Easy to customize
- Vendor-independent
- Supports multiple UPS devices
- Minimal system overhead
- Production-ready

---

# How It Works

```text
USB UPS
    │
    ▼
Network UPS Tools (NUT)
    │
    ▼
upsc command
    │
    ▼
UserParameter
    │
    ▼
Zabbix Agent
    │
    ▼
Zabbix Server
```

The Zabbix Agent executes the configured command locally and returns the output as a monitoring item.

---

# Configuration File

Create a dedicated UserParameter configuration.

Recommended location:

```text
/etc/zabbix/zabbix_agentd.d/userparameters.conf
```

Keeping custom UserParameters in a separate file simplifies maintenance and upgrades.

---

# Generic UserParameters

The following configuration supports any UPS defined in NUT.

```ini
UserParameter=ups.status[*],upsc $1 ups.status

UserParameter=ups.charge[*],upsc $1 battery.charge

UserParameter=ups.runtime[*],upsc $1 battery.runtime

UserParameter=ups.load[*],upsc $1 ups.load

UserParameter=ups.input[*],upsc $1 input.voltage

UserParameter=ups.output[*],upsc $1 output.voltage

UserParameter=ups.battery[*],upsc $1 battery.voltage

UserParameter=ups.temperature[*],upsc $1 ups.temperature

UserParameter=ups.model[*],upsc $1 device.model

UserParameter=ups.manufacturer[*],upsc $1 device.mfr

UserParameter=ups.driver[*],upsc $1 driver.name
```

The wildcard (`*`) allows one configuration to monitor unlimited UPS devices.

---

# Example Usage

Example NUT devices:

```text
ups_network

ups_servers

ups_workstations
```

Corresponding Zabbix keys:

```text
ups.status[ups_network]

ups.status[ups_servers]

ups.status[ups_workstations]
```

Battery runtime:

```text
ups.runtime[ups_network]
```

UPS load:

```text
ups.load[ups_servers]
```

Battery charge:

```text
ups.charge[ups_workstations]
```

No additional UserParameters are required.

---

# Testing UserParameters

Before importing the Zabbix Template, test each parameter locally.

Example:

```bash
zabbix_agentd -t ups.status[ups_network]
```

Expected result:

```text
OL
```

Battery charge:

```bash
zabbix_agentd -t ups.charge[ups_network]
```

Expected result:

```text
100
```

Repeat the tests for every configured UPS.

---

# Restart the Agent

After modifying the configuration:

```bash
systemctl restart zabbix-agent
```

Verify the service status.

```bash
systemctl status zabbix-agent
```

---

# Supported Metrics

The default UserParameters expose the following values.

| Metric | Description |
|----------|-------------|
| UPS Status | Current operating state |
| Battery Charge | Remaining battery percentage |
| Battery Runtime | Estimated runtime |
| UPS Load | Current output load |
| Input Voltage | Utility voltage |
| Output Voltage | UPS output voltage |
| Battery Voltage | Battery voltage |
| Battery Temperature | Temperature (if supported) |
| Device Model | UPS model |
| Manufacturer | Device manufacturer |
| Driver | Active NUT driver |

Additional metrics can easily be added if supported by the UPS.

---

# Performance

UserParameters execute only when requested by the Zabbix Server.

Advantages include:

- Low CPU usage
- Low memory consumption
- No background polling
- Fast response times

Even environments monitoring several UPS devices generate minimal system load.

---

# Best Practices

For production deployments:

- Keep UserParameters in a dedicated configuration file.
- Test every parameter before importing templates.
- Use descriptive UPS identifiers.
- Restart the Zabbix Agent after every configuration change.
- Avoid duplicate UserParameter definitions.
- Keep the configuration under version control.

---

# Troubleshooting

If a UserParameter does not return data:

Verify that NUT is working:

```bash
upsc ups_network
```

Verify the UserParameter:

```bash
zabbix_agentd -t ups.status[ups_network]
```

Check the agent log:

```bash
journalctl -u zabbix-agent
```

Restart the service:

```bash
systemctl restart zabbix-agent
```

If the problem persists, verify:

- NUT configuration
- UPS communication
- UserParameter syntax
- File permissions

---

# Summary

UserParameters provide the bridge between Network UPS Tools and Zabbix.

By using generic parameterized keys, a single configuration can monitor any number of USB-connected UPS devices while remaining simple, scalable, and easy to maintain.

---

**Previous:** [← Zabbix Template](08-zabbix-template.md)

**Next:** [Triggers →](10-triggers.md)
