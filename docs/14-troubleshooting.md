# Troubleshooting

## Overview

Even with a correctly configured monitoring environment, communication issues may occasionally occur between the operating system, Network UPS Tools (NUT), the Zabbix Agent, or the UPS itself.

This document provides a systematic approach to diagnosing and resolving the most common problems encountered when deploying this solution.

Rather than applying random fixes, always verify each component individually before moving to the next.

---

# Troubleshooting Workflow

Follow this order:

```text
USB Connection
        │
        ▼
Linux Detection
        │
        ▼
NUT Driver
        │
        ▼
NUT Services
        │
        ▼
upsc Communication
        │
        ▼
UserParameters
        │
        ▼
Zabbix Agent
        │
        ▼
Zabbix Server
```

Never troubleshoot multiple layers simultaneously.

---

# UPS Not Detected

## Symptoms

- UPS does not appear in NUT.
- `upsc` returns an error.
- No metrics are available.

## Verify USB Detection

```bash
lsusb
```

The UPS should appear in the device list.

Example:

```text
Bus 001 Device 003: UPS HID Device
```

If nothing appears:

- Verify the USB cable.
- Try another USB port.
- Reconnect the UPS.
- Restart the host if necessary.

---

# Verify Kernel Detection

Check kernel messages.

```bash
dmesg | grep -i usb
```

Look for:

- Device detected
- USB errors
- Permission errors

---

# Verify Driver Support

Run:

```bash
nut-scanner
```

or

```bash
upsc ups_network
```

If no driver is found:

- Verify UPS compatibility.
- Check the configured driver.
- Update NUT if necessary.

---

# Verify Services

Check service status.

```bash
systemctl status nut-server
```

```bash
systemctl status nut-monitor
```

Restart if necessary.

```bash
systemctl restart nut-server
systemctl restart nut-monitor
```

---

# Verify Configuration Files

Review:

```text
/etc/nut/nut.conf

/etc/nut/ups.conf

/etc/nut/upsd.conf

/etc/nut/upsd.users

/etc/nut/upsmon.conf
```

Check for:

- Typographical errors
- Incorrect UPS names
- Wrong driver
- Missing authentication

---

# Verify Communication

Run:

```bash
upsc ups_network
```

Expected output:

```text
battery.charge: 100
ups.load: 17
ups.status: OL
```

If no values are returned, NUT communication is not functioning correctly.

---

# Zabbix Agent Issues

Verify the UserParameter.

Example:

```bash
zabbix_agentd -t ups.status[ups_network]
```

Expected output:

```text
OL
```

If this fails:

- Verify UserParameter syntax.
- Restart the agent.
- Review agent logs.

---

# Restart the Agent

```bash
systemctl restart zabbix-agent
```

Verify:

```bash
systemctl status zabbix-agent
```

---

# Check Agent Logs

```bash
journalctl -u zabbix-agent
```

Look for:

- Syntax errors
- Permission issues
- Invalid UserParameters

---

# Verify Zabbix Items

If the Agent works locally but Zabbix receives no data:

Verify:

- Host configuration
- Item key
- Interface IP
- Update interval
- Template linkage

---

# USB Device Changes

If multiple identical UPS devices are installed:

Linux may enumerate devices differently after:

- Reboot
- USB reconnect
- Hardware replacement

Use persistent USB mappings instead of:

```ini
port = auto
```

Recommended:

```ini
port = /dev/ups_network
```

---

# Permission Problems

Verify that NUT has access to the USB device.

Check device permissions.

Example:

```bash
ls -l /dev/bus/usb
```

Review udev rules if custom mappings are used.

---

# Firewall

Verify connectivity.

Typical ports:

| Service | Port |
|----------|------|
| Zabbix Agent | 10050 |
| Zabbix Server | 10051 |
| NUT | 3493 |

---

# Common Problems

| Problem | Possible Cause |
|----------|----------------|
| UPS not detected | USB issue |
| No NUT communication | Driver configuration |
| No Zabbix data | UserParameter error |
| Trigger not firing | Item configuration |
| Wrong UPS monitored | USB enumeration changed |
| Communication timeout | Firewall or network issue |

---

# Diagnostic Commands

USB devices:

```bash
lsusb
```

Kernel messages:

```bash
dmesg | grep -i usb
```

UPS communication:

```bash
upsc ups_network
```

List configured UPS devices:

```bash
upsc -l
```

NUT service:

```bash
systemctl status nut-server
```

Agent test:

```bash
zabbix_agentd -t ups.status[ups_network]
```

Agent log:

```bash
journalctl -u zabbix-agent
```

---

# Before Requesting Support

Collect the following information:

- Linux distribution
- Kernel version
- NUT version
- Zabbix version
- UPS manufacturer
- UPS model
- Driver name
- `ups.conf`
- `nut.conf`
- Error messages
- Relevant log entries

Providing this information significantly speeds up troubleshooting.

---

# Best Practices

- Test each layer independently.
- Document custom configurations.
- Keep backups of configuration files.
- Avoid unnecessary configuration changes.
- Update software regularly.
- Test power failure scenarios after major changes.

---

# Summary

Most UPS monitoring issues can be resolved by following a structured troubleshooting process.

By verifying hardware detection, NUT communication, UserParameters, and Zabbix integration separately, administrators can quickly identify the root cause and restore normal operation.

A disciplined troubleshooting methodology reduces downtime and simplifies long-term maintenance.

---

**Previous:** [← Automatic Shutdown](13-automatic-shutdown.md)

**Next:** [Frequently Asked Questions →](15-faq.md)
