# Frequently Asked Questions (FAQ)

## Overview

This document answers the most frequently asked questions regarding the deployment and operation of this monitoring solution.

If your question is not answered here, review the troubleshooting guide before opening a GitHub Issue.

---

# General Questions

## What is Network UPS Tools (NUT)?

Network UPS Tools (NUT) is an open-source software suite that allows Linux systems to communicate with UPS devices.

It supports hundreds of UPS models from many manufacturers through USB, Serial and network connections.

---

## Do I need a network-enabled UPS?

No.

This project is specifically designed for **USB-connected UPS devices**.

The Linux host communicates directly with the UPS using USB.

---

## Can I monitor multiple UPS devices?

Yes.

One Linux or Proxmox host can monitor multiple USB-connected UPS devices simultaneously.

There is no need to deploy multiple monitoring servers.

---

## Is this project vendor-specific?

No.

The project is designed around **Network UPS Tools**, not a specific UPS manufacturer.

Any USB HID-compatible UPS supported by NUT should work.

---

# Zabbix Questions

## Which Zabbix versions are supported?

Currently supported:

- Zabbix 6.x LTS
- Zabbix 7.x

Older versions may require manual adjustments.

---

## Does the template support multiple UPS devices?

Yes.

The included template is designed to work with:

- Single UPS installations
- Multiple UPS deployments
- Enterprise environments

---

## Can every UPS appear as a separate host?

Yes.

Although all UPS devices are connected to a single Linux or Proxmox host, they can be represented as individual logical hosts inside Zabbix.

This approach improves:

- Dashboards
- Reporting
- Trigger management
- Availability views

---

## Does this require multiple Zabbix Agents?

No.

A single Zabbix Agent can expose metrics for multiple UPS devices using generic UserParameters.

---

# Linux Questions

## Which Linux distributions are supported?

Officially tested:

- Debian
- Ubuntu Server
- Proxmox VE

Other Linux distributions may also work if supported by NUT.

---

## Can this run inside a virtual machine?

Technically yes.

However, it is **strongly recommended** to connect the UPS directly to the physical Linux or Proxmox host.

Direct USB access provides greater reliability.

---

## Can I use USB hubs?

It is possible.

However, direct USB connections are strongly recommended for production environments.

Passive USB hubs should be avoided.

---

# Proxmox Questions

## Should NUT run inside a VM?

No.

The recommended deployment is:

- NUT on the Proxmox host
- Zabbix Agent on the Proxmox host

This eliminates unnecessary complexity.

---

## Can I automatically shut down virtual machines?

Yes.

Network UPS Tools can initiate a controlled shutdown sequence.

Typical order:

1. Virtual Machines
2. Linux Containers
3. Proxmox Host

---

## Can virtual machines start automatically after power returns?

Yes.

Configure the VM startup order within Proxmox.

NUT is responsible for safe shutdown.

Proxmox manages automatic startup.

---

# UPS Questions

## Which UPS manufacturers are supported?

Examples include:

- APC
- Eaton
- CyberPower
- NJOY
- PowerWalker
- Mustek
- Riello
- Vertiv
- Salicru

Support depends on Network UPS Tools compatibility.

---

## How do I know which driver to use?

Run:

```bash
nut-scanner
```

or

```bash
lsusb
```

The scanner usually recommends the correct driver.

---

## Why shouldn't I use `port = auto`?

`port = auto` works well for testing.

In production environments with multiple UPS devices, persistent USB mappings are recommended.

This prevents device order changes after reboot.

---

## Can I replace the UPS without changing the template?

Usually yes.

As long as the new UPS is supported by Network UPS Tools and uses the same monitoring keys, no template changes are required.

---

# Monitoring Questions

## How often should I poll UPS metrics?

Recommended intervals:

| Metric | Interval |
|----------|----------|
| UPS Status | 30 seconds |
| Battery Charge | 60 seconds |
| Runtime | 60 seconds |
| Load | 60 seconds |
| Voltage | 60 seconds |
| Device Information | 1 hour |

---

## Should I monitor battery percentage or runtime?

Runtime is generally the better indicator for shutdown decisions.

Battery percentage alone does not accurately represent remaining operating time.

---

## What should trigger a shutdown?

Recommended:

- Runtime below a configured threshold
- Critical battery condition
- Administrator-defined policies

Avoid shutting down based solely on battery percentage.

---

# Best Practices

## How often should batteries be tested?

Recommended:

- Monthly monitoring review
- Quarterly runtime test
- Annual maintenance
- Battery replacement according to manufacturer recommendations

---

## Should I simulate power failures?

Yes.

Regular testing verifies:

- UPS communication
- Alerts
- Automatic shutdown
- Recovery procedures

Testing is essential for production environments.

---

# Support

If you encounter an issue:

1. Review the documentation.
2. Follow the troubleshooting guide.
3. Verify NUT communication.
4. Verify UserParameters.
5. Collect logs before opening an issue.

Providing complete diagnostic information significantly reduces troubleshooting time.

---

# Summary

This FAQ covers the most common questions related to deploying, configuring, and maintaining a professional UPS monitoring solution using Network UPS Tools and Zabbix.

The combination of Linux, NUT, and Zabbix provides a flexible, scalable, and vendor-independent monitoring platform suitable for environments ranging from home laboratories to enterprise infrastructures.

---

**Previous:** [← Troubleshooting](14-troubleshooting.md)

**Next:** [Enterprise Deployment Checklist →](16-enterprise-checklist.md)
