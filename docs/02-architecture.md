# Architecture

## Overview

This project is built around a modular architecture that combines **Network UPS Tools (NUT)** with **Zabbix** to provide centralized monitoring of USB-connected UPS devices.

The solution is lightweight, scalable, and suitable for both small business environments and enterprise infrastructures.

The architecture separates hardware communication, data collection, monitoring, and alerting into independent components, making the system easier to maintain and expand.

---

# Architecture Components

The monitoring solution consists of the following core components:

| Component | Purpose |
|----------|---------|
| USB UPS | Provides power protection and status information |
| Linux / Proxmox Host | Hosts the NUT services and Zabbix Agent |
| Network UPS Tools (NUT) | Communicates with UPS devices |
| Zabbix Agent | Collects UPS metrics |
| Zabbix Server | Stores monitoring data |
| Zabbix Frontend | Dashboards, graphs and alerting |

---

# High-Level Architecture

```text
                 +----------------------+
                 |      USB UPS         |
                 +----------+-----------+
                            |
                          USB HID
                            |
                 +----------v-----------+
                 | Linux / Proxmox Host |
                 +----------+-----------+
                            |
                  Network UPS Tools
                            |
                 +----------v-----------+
                 |    Zabbix Agent      |
                 +----------+-----------+
                            |
                     Zabbix Protocol
                            |
                 +----------v-----------+
                 |    Zabbix Server     |
                 +----------+-----------+
                            |
                 +----------v-----------+
                 | Dashboards & Alerts  |
                 +----------------------+
```

---

# Data Flow

The monitoring process follows a simple workflow:

1. The UPS reports its current status via USB.
2. Network UPS Tools reads the device.
3. The Zabbix Agent executes UserParameters.
4. Zabbix collects the returned values.
5. Triggers evaluate system health.
6. Dashboards visualize collected metrics.
7. Alerts are generated when thresholds are exceeded.

---

# Single UPS Deployment

The simplest deployment consists of one UPS connected to a Linux server.

```text
UPS
 │
USB
 │
Linux Server
 │
NUT
 │
Zabbix Agent
 │
Zabbix Server
```

Typical use cases:

- Small offices
- Single Proxmox hosts
- NAS servers
- Home labs

---

# Multiple UPS Deployment

One Linux server can monitor several USB-connected UPS devices simultaneously.

```text
UPS Network
      │
UPS Office
      │
UPS Server
      │
USB Connections
      │
Linux / Proxmox
      │
Network UPS Tools
      │
Zabbix Agent
      │
Zabbix Server
```

Each UPS receives its own identifier inside NUT and can be monitored independently.

Examples:

- ups_network
- ups_server
- ups_office

This architecture simplifies management while avoiding the need for multiple monitoring hosts.

---

# Proxmox Integration

One of the most common deployments is a Proxmox virtualization host.

The Proxmox server:

- Hosts virtual machines
- Runs Network UPS Tools
- Runs the Zabbix Agent
- Collects data from multiple UPS devices

No additional virtual machine is required for UPS monitoring.

---

# Separation of Responsibilities

Each component performs a single task.

| Component | Responsibility |
|----------|----------------|
| UPS | Power protection |
| USB HID | Hardware communication |
| NUT | UPS communication |
| Zabbix Agent | Data collection |
| Zabbix Server | Monitoring |
| Dashboard | Visualization |
| Triggers | Alerting |

Keeping responsibilities separated improves reliability and simplifies troubleshooting.

---

# Scalability

The architecture scales easily.

Supported scenarios include:

- One UPS
- Multiple USB UPS devices
- Multiple Linux servers
- Multiple Proxmox hosts
- Centralized Zabbix Server
- Distributed monitoring

Additional UPS devices can be added without changing the monitoring architecture.

---

# Advantages

This architecture provides several benefits:

- Lightweight
- Open source
- Vendor independent
- Enterprise ready
- Easy deployment
- Centralized monitoring
- High reliability
- Excellent scalability

---

# Recommended Deployment

For production environments, the following architecture is recommended:

- Dedicated Zabbix Server
- Linux or Proxmox host
- Network UPS Tools
- USB HID-compatible UPS devices
- Ready-to-use Zabbix Template
- Centralized dashboards
- Automated alerting

This design minimizes complexity while providing complete visibility into UPS health and power events.

---

**Previous:** [← Introduction](01-introduction.md)

**Next:** [Requirements →](03-requirements.md)
