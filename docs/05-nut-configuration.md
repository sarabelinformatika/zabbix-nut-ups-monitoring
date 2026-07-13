# Network UPS Tools (NUT) Configuration

## Overview

After installing Network UPS Tools (NUT), the next step is configuring the service to communicate with one or more USB-connected UPS devices.

This guide explains the required configuration files, their purpose, and how they work together.

The configuration examples in this document are suitable for:

- Debian
- Ubuntu Server
- Proxmox VE

---

# Configuration Files

NUT uses several configuration files located in:

```text
/etc/nut/
```

The most important files are:

| File | Purpose |
|------|---------|
| nut.conf | Defines the operating mode |
| ups.conf | UPS device configuration |
| upsd.conf | NUT server configuration |
| upsd.users | Authentication |
| upsmon.conf | Monitoring daemon configuration |

---

# Configure NUT Mode

Edit:

```text
/etc/nut/nut.conf
```

Example:

```ini
MODE=standalone
```

### Available Modes

| Mode | Description |
|------|-------------|
| standalone | Single monitoring host (recommended) |
| netserver | UPS shared over the network |
| netclient | Uses a remote NUT server |
| none | Disable NUT |

For most environments, **standalone** is the recommended option.

---

# Configure UPS Devices

Edit:

```text
/etc/nut/ups.conf
```

Example for a single UPS:

```ini
[ups]
driver = usbhid-ups
port = auto
desc = "USB UPS"
```

---

# Multiple USB UPS Devices

NUT supports multiple USB-connected UPS devices.

Example:

```ini
[ups_network]
driver = usbhid-ups
port = auto
desc = "Network UPS"

[ups_server]
driver = usbhid-ups
port = auto
desc = "Server UPS"

[ups_office]
driver = usbhid-ups
port = auto
desc = "Office UPS"
```

Each UPS receives a unique identifier.

These identifiers will later be used by:

- upsc
- Zabbix Agent
- UserParameters
- Templates

---

# Configure NUT Server

Edit:

```text
/etc/nut/upsd.conf
```

Example:

```ini
LISTEN 127.0.0.1 3493
LISTEN ::1 3493
```

If remote NUT clients are required, additional interfaces may be added.

---

# Configure Authentication

Edit:

```text
/etc/nut/upsd.users
```

Example:

```ini
[admin]
password = StrongPassword
actions = SET
actions = FSD
instcmds = ALL

[zabbix]
password = StrongPassword
upsmon primary
```

Use strong passwords in production environments.

---

# Configure UPS Monitor

Edit:

```text
/etc/nut/upsmon.conf
```

Example:

```ini
MONITOR ups@localhost 1 zabbix StrongPassword primary

MINSUPPLIES 1

SHUTDOWNCMD "/sbin/shutdown -h now"

POWERDOWNFLAG /etc/killpower
```

The monitoring daemon watches UPS status and can initiate a controlled shutdown when required.

---

# Verify Configuration

Check the configuration syntax.

```bash
upsdrvctl start
```

Then verify communication.

```bash
upsc ups
```

Example output:

```text
battery.charge: 100
battery.runtime: 2760
battery.voltage: 27.2
device.model: UPS
driver.name: usbhid-ups
input.voltage: 230.0
output.voltage: 230.0
ups.load: 14
ups.status: OL
```

If values are displayed, communication is working correctly.

---

# Start Services

Enable NUT services.

```bash
systemctl enable nut-server
systemctl enable nut-monitor
```

Start them.

```bash
systemctl restart nut-server
systemctl restart nut-monitor
```

Verify status.

```bash
systemctl status nut-server
systemctl status nut-monitor
```

---

# Useful Commands

Display UPS information:

```bash
upsc ups
```

List available commands:

```bash
upscmd -l ups
```

List variables:

```bash
upsc ups
```

Scan for supported UPS devices:

```bash
nut-scanner
```

---

# Troubleshooting

If the UPS is not detected:

- Verify the USB cable.
- Check `lsusb`.
- Review `dmesg`.
- Confirm the correct driver.
- Verify file permissions.
- Restart NUT services.

Useful commands:

```bash
lsusb
```

```bash
dmesg | grep -i usb
```

```bash
journalctl -u nut-server
```

```bash
journalctl -u nut-monitor
```

---

# Best Practices

For production environments:

- Use descriptive UPS names.
- Connect UPS devices directly via USB.
- Avoid USB hubs whenever possible.
- Document each UPS purpose.
- Test failover after configuration.
- Keep NUT updated.
- Monitor service status.

---

# Next Step

Once NUT is correctly configured and communication has been verified, the next step is integrating the UPS data with the Zabbix Agent.

---

**Previous:** [← Installation](04-installation.md)

**Next:** [Multiple USB UPS Devices →](06-multiple-usb-ups.md)
