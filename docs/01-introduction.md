# Introduction

## Overview

Modern IT infrastructures depend on continuous availability. Even a short power outage can lead to interrupted services, corrupted data, failed backups, or unexpected shutdowns.

A reliable Uninterruptible Power Supply (UPS) protects critical systems against these situations. However, simply installing a UPS is not enough. Without monitoring, administrators often have no visibility into battery health, remaining runtime, load level, or power events until a failure occurs.

This repository provides a complete open-source monitoring solution for USB-connected UPS devices using:

- Network UPS Tools (NUT)
- Zabbix
- Linux
- Proxmox VE
- USB HID-compatible UPS devices

The goal is to provide a professional, enterprise-ready monitoring framework that is easy to deploy, easy to maintain, and fully documented.

---

# Why UPS Monitoring Matters

A UPS is one of the most critical components of an IT infrastructure, yet it is often one of the least monitored.

Without proper monitoring, administrators may not notice:

- Failing batteries
- Communication problems
- UPS overload conditions
- Reduced battery runtime
- Unexpected transfers to battery mode
- Power quality issues
- Hardware failures

These problems frequently remain hidden until a real power outage occurs.

Continuous monitoring allows administrators to detect issues early and perform maintenance before service availability is affected.

---

# Project Goals

This project was created to provide a standardized solution for monitoring USB-connected UPS devices in Linux environments.

Primary objectives include:

- Simple deployment
- Enterprise-grade documentation
- Native Linux support
- Full Zabbix integration
- Multiple UPS support
- Proxmox compatibility
- Production-ready configuration examples
- Open-source licensing

Rather than focusing on a single UPS vendor, this project is designed around **Network UPS Tools (NUT)**, allowing support for many different USB HID-compatible UPS devices.

---

# Supported Infrastructure

This documentation is intended for environments such as:

- Small businesses
- Medium-sized enterprises
- Home laboratories
- Datacenters
- Virtualization hosts
- Proxmox clusters
- Linux servers
- Monitoring servers
- Network infrastructure

---

# Typical Architecture

A common deployment consists of:

```text
                UPS
                 │
             USB Connection
                 │
         Linux / Proxmox Host
                 │
          Network UPS Tools
                 │
            Zabbix Agent
                 │
           Zabbix Server
                 │
        Dashboards & Alerts
```

The same architecture also supports multiple UPS devices connected simultaneously to a single Linux host.

---

# What You Will Learn

This guide covers every step required to deploy a professional UPS monitoring solution.

Topics include:

- Installing Network UPS Tools
- Configuring USB UPS devices
- Monitoring multiple UPS units
- Integrating with Zabbix
- Creating UserParameters
- Importing templates
- Configuring triggers
- Low Level Discovery
- Automatic shutdown procedures
- Proxmox integration
- Troubleshooting
- Enterprise deployment recommendations

No previous experience with Network UPS Tools is required.

---

# Key Features

This project includes:

- Enterprise documentation
- Ready-to-import Zabbix template
- Linux installation guide
- Proxmox integration
- Multiple USB UPS support
- UserParameter examples
- Trigger recommendations
- Discovery examples
- Health monitoring
- Production deployment guidance

---

# Open Source Philosophy

This repository is published to help system administrators deploy reliable UPS monitoring without relying on proprietary vendor software.

Every configuration example included in this project has been designed with simplicity, maintainability, and long-term operation in mind.

Contributions from the community are welcome and help improve compatibility with additional UPS devices and Linux distributions.

---

# Who Should Use This Project?

This repository is intended for:

- Linux administrators
- System engineers
- Infrastructure engineers
- DevOps engineers
- Proxmox administrators
- Zabbix administrators
- MSP providers
- IT consultants
- Enterprise IT departments

Whether you operate a single server or an entire virtualization platform, this documentation provides the tools necessary to monitor UPS devices efficiently and reliably.

---

**Next:** [Architecture →](02-architecture.md)
