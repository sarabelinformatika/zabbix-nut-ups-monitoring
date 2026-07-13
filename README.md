# Zabbix NUT UPS Monitoring

<p align="center">
  <img src="images/zabbix-nut-ups-monitoring.jpg" alt="Zabbix NUT UPS Monitoring">
</p>

<p align="center">

![Platform](https://img.shields.io/badge/Platform-Linux-blue)
![Proxmox](https://img.shields.io/badge/Proxmox-Compatible-E57000)
![Zabbix](https://img.shields.io/badge/Zabbix-6.x%20%7C%207.x-D40000)
![NUT](https://img.shields.io/badge/NUT-Network%20UPS%20Tools-success)
![USB HID](https://img.shields.io/badge/USB-HID-informational)

![GitHub release](https://img.shields.io/github/v/release/sarabelinformatika/zabbix-nut-ups-monitoring)
![GitHub stars](https://img.shields.io/github/stars/sarabelinformatika/zabbix-nut-ups-monitoring?style=social)
![GitHub forks](https://img.shields.io/github/forks/sarabelinformatika/zabbix-nut-ups-monitoring?style=social)

![GitHub issues](https://img.shields.io/github/issues/sarabelinformatika/zabbix-nut-ups-monitoring)
![GitHub last commit](https://img.shields.io/github/last-commit/sarabelinformatika/zabbix-nut-ups-monitoring)
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/sarabelinformatika/zabbix-nut-ups-monitoring)

![License](https://img.shields.io/github/license/sarabelinformatika/zabbix-nut-ups-monitoring)

</p>

---

<p align="center">
Enterprise-grade monitoring solution for USB-connected UPS devices using
<strong>Network UPS Tools (NUT)</strong>, <strong>Zabbix</strong>, and
<strong>Proxmox VE</strong>.
</p>

---

## Overview

**Zabbix NUT UPS Monitoring** is a professional monitoring solution designed for **Linux**, **Proxmox VE**, and **Network UPS Tools (NUT)** environments.

The project provides a complete monitoring framework for USB-connected UPS devices, including:

- Network UPS Tools (NUT) configuration
- Zabbix Agent integration
- Ready-to-use Zabbix Template
- UserParameter configuration
- Multiple USB UPS monitoring
- Trigger configuration
- Low Level Discovery (LLD)
- Automatic shutdown integration
- Enterprise deployment documentation

The goal of this repository is to simplify UPS monitoring while providing production-ready documentation suitable for enterprise environments.

---

# Features

- USB HID UPS support
- Network UPS Tools (NUT)
- Zabbix 6.x / 7.x compatible
- Proxmox VE support
- Multiple UPS monitoring
- Ready-to-import Zabbix Template
- UserParameter configuration
- Battery monitoring
- Runtime monitoring
- Load monitoring
- Input / Output voltage
- UPS health monitoring
- Enterprise documentation
- Open-source

---

# Supported Platforms

| Component | Supported |
|------------|-----------|
| Debian | ✅ |
| Ubuntu Server | ✅ |
| Proxmox VE | ✅ |
| Zabbix Agent 2 | ✅ |
| Zabbix Server 6.x | ✅ |
| Zabbix Server 7.x | ✅ |
| Network UPS Tools | ✅ |
| USB HID UPS | ✅ |

---

# Repository Structure

```text
zabbix-nut-ups-monitoring/
│
├── README.md
├── LICENSE
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── DISCLAIMER.md
├── SECURITY.md
├── SUPPORTED_VERSIONS.md
│
├── docs/
├── templates/
├── scripts/
├── examples/
└── images/
```

---

# Documentation

| Document | Description |
|----------|-------------|
| 01 | Introduction |
| 02 | Architecture |
| 03 | Requirements |
| 04 | Installation |
| 05 | NUT Configuration |
| 06 | Multiple USB UPS |
| 07 | Zabbix Agent |
| 08 | Zabbix Template |
| 09 | UserParameters |
| 10 | Triggers |
| 11 | Low Level Discovery |
| 12 | Proxmox Integration |
| 13 | Automatic Shutdown |
| 14 | Troubleshooting |
| 15 | Frequently Asked Questions |
| 16 | Enterprise Checklist |

---

# Monitoring Capabilities

The template can monitor:

- UPS Status
- Battery Charge
- Battery Runtime
- Battery Voltage
- Battery Temperature
- UPS Load
- Input Voltage
- Output Voltage
- Transfer Events
- Communication Status
- UPS Model
- UPS Manufacturer

---

# Multiple UPS Support

The project fully supports monitoring multiple USB-connected UPS devices from a single Linux or Proxmox host.

Example:

```
UPS Network
UPS Office
UPS Server
```

Each UPS can be monitored independently inside Zabbix.

---

# Installation

Detailed installation instructions are available in:

```
docs/04-installation.md
```

---

# Quick Start

1. Install Network UPS Tools
2. Configure NUT
3. Install Zabbix Agent
4. Copy UserParameters
5. Import Zabbix Template
6. Start monitoring

---

# Why This Project?

Many UPS vendors provide limited monitoring software or Windows-only tools.

This repository offers:

- Linux native
- Enterprise ready
- Open source
- Fully documented
- Easy deployment
- Production tested architecture

---

# Contributing

Contributions, feature requests and improvements are welcome.

Please read:

- CONTRIBUTING.md
- CODE_OF_CONDUCT.md

---

# Security

If you discover a security issue, please follow the instructions described in **SECURITY.md**.

---

# License

This project is licensed under the MIT License.

See **LICENSE** for details.

---

# Author

**SARABEL Informatika**

# Related Resources

- **[Company Website](https://sarabelinformatika.hu)**

- **[Why Continuous Server and Network Monitoring Is Essential](https://sarabelinformatika.hu/blog/miert-fontos-a-folyamatos-szerver-es-halozati-monitoring-igy-elozhetok-meg-a-varatlan-rendszerleallasok)**

- **[More Open Source Projects](https://github.com/sarabelinformatika)**
