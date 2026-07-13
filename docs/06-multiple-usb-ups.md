# Monitoring Multiple USB UPS Devices

## Overview

One of the greatest strengths of **Network UPS Tools (NUT)** is its ability to monitor multiple USB-connected UPS devices from a single Linux host.

This makes it an excellent solution for:

- Small and medium-sized businesses
- Enterprise server rooms
- Proxmox virtualization hosts
- Network cabinets
- Datacenters
- Managed Service Providers (MSPs)

Instead of deploying multiple monitoring servers, one Linux or Proxmox host can manage several UPS devices simultaneously.

---

# Why Monitor Multiple UPS Devices?

Many environments protect different systems with separate UPS units.

Typical examples include:

- Network infrastructure
- Server infrastructure
- Workstations
- Storage systems
- Security systems

Monitoring each UPS independently provides significantly better visibility into the health of the entire infrastructure.

---

# Example Infrastructure

```text
                 Internet
                     │
             ISP Router / ONT
                     │
              MikroTik Router
                     │
                Core Switch
                     │
     ┌───────────────┼───────────────┐
     │               │               │
 Workstations     Proxmox Host     NAS
```

Power protection:

```text
UPS #1
├── MikroTik
├── Switch
└── ISP Router

UPS #2
├── Workstation 1
└── Workstation 2

UPS #3
├── Workstation 3
└── Workstation 4
```

Each UPS is monitored independently.

---

# Recommended Deployment

The recommended architecture consists of:

```text
                 USB UPS #1
                      │
                 USB UPS #2
                      │
                 USB UPS #3
                      │
             Linux / Proxmox Host
                      │
              Network UPS Tools
                      │
                Zabbix Agent
                      │
                Zabbix Server
```

Only one Linux host is required.

---

# Naming Convention

Avoid generic names.

Instead of:

```
ups1
ups2
ups3
```

Use descriptive identifiers.

Example:

```ini
ups_network
ups_workstations
ups_servers
```

This improves readability inside:

- NUT
- Zabbix
- Dashboards
- Alerts
- Documentation

---

# Example Configuration

Example `ups.conf`

```ini
[ups_network]
driver = usbhid-ups
port = auto
desc = "Network Infrastructure"

[ups_workstations]
driver = usbhid-ups
port = auto
desc = "Office Workstations"

[ups_servers]
driver = usbhid-ups
port = auto
desc = "Server Infrastructure"
```

---

# Avoid Using `port = auto` in Production

Although `port = auto` is convenient during testing, it is **not recommended for production environments**.

When several identical UPS devices are connected, Linux may enumerate USB devices in a different order after:

- reboot
- USB reconnect
- kernel updates
- hardware replacement

This may cause UPS identifiers to swap unexpectedly.

---

# Recommended Solution

Use persistent USB device identification with **udev**.

Benefits include:

- Stable device mapping
- Reliable reboots
- Predictable monitoring
- Enterprise-grade deployment

---

# Persistent USB Device Mapping

Identify connected UPS devices.

```bash
lsusb
```

Obtain detailed USB information.

```bash
udevadm info -a -n /dev/bus/usb/001/002
```

Create persistent rules.

Example:

```text
/etc/udev/rules.d/99-ups.rules
```

Example rule:

```text
SUBSYSTEM=="usb", ATTR{idVendor}=="XXXX", ATTR{idProduct}=="YYYY", SYMLINK+="ups_network"
```

Repeat for each UPS.

---

# Updated NUT Configuration

Instead of:

```ini
port = auto
```

Use:

```ini
port = /dev/ups_network
```

or

```ini
port = /dev/ups_servers
```

This ensures each UPS always maps to the correct configuration.

---

# Zabbix Integration

Each UPS can be monitored individually.

Example UserParameters:

```text
ups.status[ups_network]
ups.status[ups_workstations]
ups.status[ups_servers]
```

The same applies to:

- battery charge
- runtime
- load
- voltage
- temperature

---

# Separate Zabbix Hosts

Although all UPS devices are physically connected to the same Linux or Proxmox server, they can be represented as separate hosts inside Zabbix.

Example:

| Zabbix Host | Purpose |
|--------------|---------|
| UPS Network | Network infrastructure |
| UPS Workstations | Office computers |
| UPS Servers | Critical servers |

All three hosts may point to the same Zabbix Agent IP address while using different item keys.

This approach provides:

- Cleaner dashboards
- Independent triggers
- Separate availability views
- Better reporting

---

# Benefits

Monitoring multiple UPS devices from one host offers several advantages.

- Lower hardware costs
- Easier administration
- Centralized monitoring
- Better scalability
- Simplified maintenance
- Reduced power consumption
- Consistent configuration

---

# Best Practices

For production deployments:

- Use descriptive UPS names.
- Use persistent USB mappings.
- Avoid USB hubs whenever possible.
- Test each UPS individually.
- Verify battery runtime.
- Document connected equipment.
- Keep NUT updated.
- Test failover regularly.

---

# Summary

A single Linux or Proxmox host can reliably monitor multiple USB-connected UPS devices using Network UPS Tools.

With persistent USB device mapping and proper naming conventions, the solution scales well from small offices to enterprise environments while remaining simple to maintain.

---

**Previous:** [← NUT Configuration](05-nut-configuration.md)

**Next:** [Zabbix Agent Integration →](07-zabbix-agent.md)
