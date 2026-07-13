# Enterprise Deployment Checklist

## Overview

Deploying UPS monitoring in a production environment requires more than simply installing software.

A reliable implementation includes proper hardware installation, standardized configuration, documentation, monitoring, testing, and ongoing maintenance.

This checklist summarizes the recommended best practices presented throughout this guide.

---

# Infrastructure

## Operating System

- [ ] Supported Linux distribution installed
- [ ] Operating system fully updated
- [ ] Time synchronization configured
- [ ] Administrative access verified

---

## UPS Hardware

- [ ] UPS connected directly via USB
- [ ] High-quality USB cable used
- [ ] UPS detected by Linux
- [ ] UPS firmware verified (if applicable)
- [ ] Battery health confirmed
- [ ] Connected equipment documented

---

## Network UPS Tools (NUT)

- [ ] NUT installed
- [ ] Correct driver configured
- [ ] `nut.conf` configured
- [ ] `ups.conf` configured
- [ ] `upsd.conf` configured
- [ ] `upsd.users` configured
- [ ] `upsmon.conf` configured
- [ ] NUT services enabled
- [ ] NUT services running

---

## Multiple UPS Deployments

- [ ] Every UPS has a descriptive identifier
- [ ] Persistent USB mappings configured
- [ ] USB hubs avoided where possible
- [ ] UPS naming documented
- [ ] All UPS devices verified after reboot

---

## Zabbix Agent

- [ ] Zabbix Agent installed
- [ ] UserParameters configured
- [ ] Agent restarted
- [ ] UserParameters tested
- [ ] Agent communication verified

---

## Zabbix Template

- [ ] Template imported
- [ ] Template linked to host(s)
- [ ] Items collecting data
- [ ] Graphs generating correctly
- [ ] Value Maps applied
- [ ] Macros reviewed

---

## Discovery

- [ ] Low Level Discovery enabled (if used)
- [ ] Discovery rule tested
- [ ] Item prototypes verified
- [ ] Trigger prototypes verified
- [ ] Graph prototypes verified

---

## Triggers

Verify that the following alerts work correctly.

- [ ] UPS On Battery
- [ ] Battery Charge Low
- [ ] Runtime Critical
- [ ] UPS Communication Lost
- [ ] UPS Overload
- [ ] Replace Battery
- [ ] Utility Power Restored

---

## Dashboards

- [ ] Battery Charge displayed
- [ ] Runtime displayed
- [ ] UPS Load displayed
- [ ] Input Voltage displayed
- [ ] Output Voltage displayed
- [ ] Trigger status visible

---

## Automatic Shutdown

- [ ] Runtime threshold configured
- [ ] Shutdown sequence documented
- [ ] VM shutdown verified
- [ ] Container shutdown verified
- [ ] Host shutdown verified
- [ ] UPS shutdown verified
- [ ] Automatic startup verified

---

## Security

- [ ] Strong passwords configured
- [ ] Firewall rules verified
- [ ] Administrative access restricted
- [ ] Configuration files backed up
- [ ] System updates applied

---

## Documentation

- [ ] UPS inventory completed
- [ ] Protected equipment documented
- [ ] Configuration files archived
- [ ] Recovery procedures documented
- [ ] Maintenance schedule created

---

## Testing

The following tests should be completed before production deployment.

### UPS Communication

- [ ] `upsc` returns valid data
- [ ] All configured UPS devices respond
- [ ] Driver communication verified

---

### Zabbix

- [ ] All items receive data
- [ ] Graphs update correctly
- [ ] Triggers fire correctly
- [ ] Trigger recovery verified

---

### Power Failure

Simulate a controlled power failure.

Verify:

- [ ] UPS switches to battery
- [ ] Runtime decreases
- [ ] Alerts generated
- [ ] Shutdown sequence executed
- [ ] Host powers off correctly
- [ ] Recovery after power restoration

---

## Maintenance

Recommended maintenance schedule.

| Task | Frequency |
|------|-----------|
| Review alerts | Daily |
| Review dashboards | Weekly |
| Verify battery health | Monthly |
| Test UPS runtime | Quarterly |
| Test shutdown procedure | Quarterly |
| Update Linux | Monthly |
| Update NUT | As required |
| Update Zabbix | As required |
| Replace UPS batteries | According to manufacturer recommendations |

---

# Production Readiness Checklist

Before placing the monitoring solution into production, confirm that:

- [ ] Hardware installation is complete.
- [ ] UPS communication is stable.
- [ ] NUT configuration has been validated.
- [ ] Zabbix monitoring is operational.
- [ ] Alerting has been tested.
- [ ] Automatic shutdown has been verified.
- [ ] Recovery procedures have been documented.
- [ ] Maintenance responsibilities have been assigned.

---

# Conclusion

By following this checklist, administrators can deploy a reliable, scalable, and maintainable UPS monitoring solution suitable for production environments.

The combination of **Linux**, **Network UPS Tools (NUT)**, **Proxmox**, and **Zabbix** provides a flexible and vendor-independent platform that helps protect critical infrastructure from unexpected power events while ensuring complete visibility into UPS health and availability.

---

## Thank You

Thank you for using **Zabbix NUT UPS Monitoring**.

If this project helped you, consider:

- ⭐ Starring this repository
- 🍴 Forking the project
- 🐞 Reporting issues
- 💡 Suggesting improvements
- 🤝 Contributing to future releases

Visit:

🌐 https://sarabelinformatika.hu

📚 https://github.com/sarabelinformatika

---

**Previous:** [← Frequently Asked Questions](15-faq.md)
