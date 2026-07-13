# Proxmox Integration

## Overview

Proxmox Virtual Environment is one of the most common platforms for virtualization in small and medium-sized enterprises.

By integrating **Network UPS Tools (NUT)** directly into the Proxmox host, administrators can monitor one or more USB-connected UPS devices while also protecting virtual machines and the host itself during power failures.

This repository recommends using the **Proxmox host as the central UPS monitoring server**.

---

# Recommended Architecture

```text
                 +--------------------+
                 |   USB UPS #1       |
                 +----------+---------+
                            |
                 +----------+---------+
                 |   USB UPS #2       |
                 +----------+---------+
                            |
                 +----------+---------+
                 |   USB UPS #3       |
                 +----------+---------+
                            |
                          USB
                            |
                +-----------v------------+
                |     Proxmox VE Host    |
                |------------------------|
                | Network UPS Tools      |
                | Zabbix Agent           |
                +-----------+------------+
                            |
                     Zabbix Protocol
                            |
                +-----------v------------+
                |     Zabbix Server      |
                +------------------------+
```

One Proxmox host can monitor multiple UPS devices simultaneously.

---

# Why Run NUT on the Proxmox Host?

Running NUT directly on the Proxmox host provides several advantages.

- No additional virtual machine required
- Lower resource usage
- Direct USB access
- Easier maintenance
- Faster communication
- Simpler architecture

This approach is recommended for most deployments.

---

# USB Connection

Each UPS should be connected directly to the Proxmox server.

Recommended:

- Dedicated USB ports
- High-quality USB cables
- Avoid passive USB hubs
- Label each USB cable

Reliable USB connectivity is essential for stable monitoring.

---

# Multiple UPS Configuration

Example deployment:

| UPS | Protected Equipment |
|------|---------------------|
| ups_network | Router, Firewall, Switch |
| ups_workstations | Office PCs |
| ups_servers | Servers and Storage |

Each UPS has its own configuration in NUT while sharing the same Zabbix Agent.

---

# Zabbix Agent

Only one Zabbix Agent is required.

The agent executes UserParameters such as:

```text
ups.status[ups_network]

ups.status[ups_workstations]

ups.status[ups_servers]
```

No additional agents are necessary.

---

# Separate Zabbix Hosts

Although the UPS devices are physically connected to a single Proxmox server, they can appear as independent hosts inside Zabbix.

Example:

| Zabbix Host | Function |
|--------------|----------|
| UPS Network | Network infrastructure |
| UPS Workstations | Office UPS |
| UPS Servers | Server infrastructure |

Each host points to the same Zabbix Agent but uses different monitoring keys.

This approach provides:

- Cleaner dashboards
- Better reporting
- Separate availability views
- Independent trigger handling

---

# Recommended Naming

Use descriptive identifiers.

Good examples:

```text
ups_network

ups_servers

ups_workstations

ups_storage
```

Avoid:

```text
ups1

ups2

ups3
```

Descriptive names make monitoring easier to understand.

---

# Automatic Shutdown

Network UPS Tools supports controlled shutdown procedures.

Typical sequence:

```text
Utility Power Failure
          │
UPS switches to battery
          │
Battery runtime decreases
          │
Warning generated
          │
Virtual Machines shutdown
          │
Proxmox Host shutdown
          │
UPS powers off
```

A controlled shutdown protects both virtual machines and storage.

---

# Monitoring the Proxmox Host

Besides UPS monitoring, the Proxmox host should also monitor:

- CPU usage
- Memory usage
- Storage utilization
- Filesystem health
- Network interfaces
- System temperature
- SMART status
- RAID health

Combining infrastructure monitoring with UPS monitoring provides complete visibility into the virtualization platform.

---

# High Availability Considerations

In clustered environments:

- Monitor each UPS independently.
- Protect every physical host with its own UPS.
- Avoid sharing one UPS between multiple critical hosts unless properly sized.
- Test failover procedures regularly.

UPS monitoring should be considered part of the overall High Availability strategy.

---

# Maintenance

Regular maintenance should include:

- UPS battery testing
- Runtime verification
- USB cable inspection
- NUT service verification
- Zabbix Agent verification
- Trigger testing
- Shutdown testing

Testing is just as important as monitoring.

---

# Best Practices

For production deployments:

- Run NUT directly on the Proxmox host.
- Use persistent USB device mappings.
- Keep UserParameters generic.
- Monitor every UPS individually.
- Test power failure scenarios.
- Document protected equipment.
- Keep NUT and Zabbix updated.

---

# Summary

Running Network UPS Tools directly on a Proxmox host provides a simple, efficient, and highly reliable monitoring architecture.

Combined with Zabbix, this approach enables centralized monitoring of multiple USB-connected UPS devices while maintaining excellent scalability and minimal administrative overhead.

---

**Previous:** [← Low Level Discovery (LLD)](11-lld-discovery.md)

**Next:** [Automatic Shutdown →](13-automatic-shutdown.md)
