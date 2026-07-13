# Zabbix Agent Integration

## Overview

Once Network UPS Tools (NUT) is properly configured and able to communicate with the UPS devices, the next step is exposing UPS metrics to Zabbix.

This project uses **Zabbix Agent UserParameters** to collect data directly from NUT without requiring additional middleware.

The result is a lightweight, flexible, and production-ready monitoring solution.

---

# Architecture

```text
USB UPS
    │
    ▼
Network UPS Tools (NUT)
    │
    ▼
upsc
    │
    ▼
Zabbix Agent
    │
    ▼
Zabbix Server
```

The Zabbix Agent executes NUT commands locally and returns the results to the Zabbix Server.

---

# Why UserParameters?

UserParameters provide several advantages:

- Native Zabbix integration
- Lightweight implementation
- Easy maintenance
- Vendor-independent monitoring
- No additional software required
- Compatible with Linux and Proxmox

---

# Verify NUT First

Before configuring Zabbix, verify that NUT is working correctly.

Example:

```bash
upsc ups_network
```

Expected output:

```text
battery.charge: 100
battery.runtime: 2760
battery.voltage: 27.1
driver.name: usbhid-ups
input.voltage: 230.0
output.voltage: 230.0
ups.load: 18
ups.status: OL
```

If this command fails, solve the NUT configuration before continuing.

---

# UserParameter Configuration

Create a new configuration file.

```text
/etc/zabbix/zabbix_agentd.d/userparameters.conf
```

Example configuration:

```ini
UserParameter=ups.status[*],upsc $1 ups.status

UserParameter=ups.charge[*],upsc $1 battery.charge

UserParameter=ups.runtime[*],upsc $1 battery.runtime

UserParameter=ups.load[*],upsc $1 ups.load

UserParameter=ups.input[*],upsc $1 input.voltage

UserParameter=ups.output[*],upsc $1 output.voltage

UserParameter=ups.battery[*],upsc $1 battery.voltage

UserParameter=ups.temperature[*],upsc $1 ups.temperature
```

The wildcard allows a single configuration to monitor multiple UPS devices.

---

# Examples

Monitor UPS status:

```text
ups.status[ups_network]
```

Battery charge:

```text
ups.charge[ups_network]
```

Runtime:

```text
ups.runtime[ups_network]
```

Load:

```text
ups.load[ups_network]
```

Input voltage:

```text
ups.input[ups_network]
```

Output voltage:

```text
ups.output[ups_network]
```

Battery voltage:

```text
ups.battery[ups_network]
```

Temperature:

```text
ups.temperature[ups_network]
```

The same keys work for every configured UPS.

Example:

```text
ups.status[ups_servers]

ups.status[ups_workstations]
```

---

# Restart the Zabbix Agent

Reload the configuration.

```bash
systemctl restart zabbix-agent
```

Verify that the service starts successfully.

```bash
systemctl status zabbix-agent
```

---

# Test UserParameters

Use the built-in testing command.

Example:

```bash
zabbix_agentd -t ups.status[ups_network]
```

Expected output:

```text
OL
```

Battery charge:

```bash
zabbix_agentd -t ups.charge[ups_network]
```

Example:

```text
100
```

Repeat the tests for every configured UPS.

---

# Multiple UPS Support

One Zabbix Agent can expose data for many UPS devices.

Example:

```text
ups_network

ups_servers

ups_workstations
```

Every UPS uses the same UserParameters with a different identifier.

No additional agent instances are required.

---

# Best Practices

Recommended naming:

```
ups_network
ups_servers
ups_workstations
ups_lab
ups_storage
```

Avoid generic names like:

```
ups1

ups2

ups3
```

Descriptive names simplify:

- dashboards
- maintenance
- triggers
- troubleshooting
- documentation

---

# Security Considerations

The Zabbix Agent only executes local NUT commands.

Recommendations:

- Restrict agent access.
- Use passive or active checks according to your environment.
- Keep the agent updated.
- Limit firewall access to trusted Zabbix Servers.

---

# Troubleshooting

If an item returns no data:

Verify NUT:

```bash
upsc ups_network
```

Verify UserParameter:

```bash
zabbix_agentd -t ups.status[ups_network]
```

Check logs:

```bash
journalctl -u zabbix-agent
```

Restart the service:

```bash
systemctl restart zabbix-agent
```

---

# Summary

The Zabbix Agent acts as the bridge between Network UPS Tools and the Zabbix Server.

Using generic UserParameters provides:

- Vendor-independent monitoring
- Multiple UPS support
- Low maintenance
- High scalability
- Easy deployment

This approach keeps the monitoring solution simple while remaining suitable for enterprise environments.

---

**Previous:** [← Multiple USB UPS Devices](06-multiple-usb-ups.md)

**Next:** [Zabbix Template →](08-zabbix-template.md)
