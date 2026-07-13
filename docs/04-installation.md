# Installation

## Overview

This guide explains how to install and configure the required software components for monitoring USB-connected UPS devices using **Network UPS Tools (NUT)** and **Zabbix**.

The installation process has been tested on:

- Debian 12
- Debian 13
- Ubuntu Server 22.04 LTS
- Ubuntu Server 24.04 LTS
- Proxmox VE 8.x

---

# Installation Workflow

The deployment consists of the following steps:

1. Update the operating system
2. Install Network UPS Tools (NUT)
3. Detect the UPS device
4. Configure NUT
5. Verify communication
6. Install the Zabbix Agent
7. Configure UserParameters
8. Import the Zabbix Template

---

# Update the System

Before installing any packages, update the operating system.

```bash
apt update
apt upgrade -y
```

Reboot if a kernel update has been installed.

---

# Install Network UPS Tools

Install the required NUT packages.

```bash
apt install nut nut-client nut-server nut-scanner -y
```

Verify the installation.

```bash
nut-scanner --version
```

---

# Enable USB Support

Most modern Linux kernels include USB HID support by default.

Verify that the required modules are loaded.

```bash
lsmod | grep hid
```

Typical output includes:

```
usbhid
hid
hid_generic
```

---

# Connect the UPS

Connect the UPS directly to the Linux or Proxmox host using a USB cable.

Avoid:

- USB extension cables
- Unpowered USB hubs
- Poor-quality USB cables

Direct connections provide the most reliable communication.

---

# Verify USB Detection

Check whether Linux detects the UPS.

```bash
lsusb
```

Example output:

```text
Bus 001 Device 004: UPS HID Device
```

You may also inspect kernel messages.

```bash
dmesg | grep -i usb
```

---

# Detect Supported Devices

Run the NUT scanner.

```bash
nut-scanner
```

If the UPS is supported, the scanner will display the recommended driver configuration.

---

# Verify Available Drivers

Network UPS Tools supports many UPS manufacturers.

List available drivers.

```bash
upsdrvctl -h
```

Most USB HID devices use:

```
usbhid-ups
```

---

# Verify Installed Services

Check the installed services.

```bash
systemctl status nut-server
systemctl status nut-monitor
```

The services may not yet be running until configuration is completed.

This is expected.

---

# Install Zabbix Agent

Install the Zabbix Agent if it is not already present.

Example:

```bash
apt install zabbix-agent -y
```

Verify the installation.

```bash
systemctl status zabbix-agent
```

---

# Verify Connectivity

Ensure the monitoring server can communicate with the Zabbix Agent.

Typical Agent port:

```
10050/TCP
```

Verify firewall rules if necessary.

---

# Recommended Directory Structure

The default installation uses:

```text
/etc/nut/
/etc/zabbix/
/etc/zabbix/zabbix_agentd.d/
```

No custom directory layout is required.

---

# Installation Checklist

Before continuing, verify:

- Linux is fully updated.
- Network UPS Tools is installed.
- Zabbix Agent is installed.
- The UPS is connected via USB.
- Linux detects the UPS.
- Required services are installed.
- Administrative access is available.

---

# Next Step

The next document explains how to configure **Network UPS Tools (NUT)** to communicate with one or more USB-connected UPS devices.

---

**Previous:** [← Requirements](03-requirements.md)

**Next:** [NUT Configuration →](05-nut-configuration.md)
