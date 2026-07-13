# Automatic Shutdown

## Overview

Monitoring a UPS is only part of a complete power protection strategy.

When utility power is lost for an extended period, the remaining battery capacity eventually becomes insufficient to safely operate connected equipment.

At this point, the goal changes from maintaining uptime to ensuring a controlled shutdown that protects:

- Virtual Machines
- Containers
- Storage
- Filesystems
- Databases
- Applications
- The Proxmox host itself

Network UPS Tools (NUT) provides all the required functionality to automate this process.

---

# Why Automatic Shutdown?

Unexpected power loss may result in:

- Filesystem corruption
- Database corruption
- Incomplete backups
- Damaged virtual machines
- Service interruption
- RAID inconsistencies

A controlled shutdown dramatically reduces these risks.

---

# Recommended Shutdown Sequence

The following sequence is recommended for production environments.

```text
Utility Power Failure
          │
          ▼
UPS switches to battery
          │
          ▼
NUT detects battery operation
          │
          ▼
Zabbix generates alert
          │
          ▼
Battery runtime reaches threshold
          │
          ▼
Virtual Machines shutdown
          │
          ▼
Linux Containers shutdown
          │
          ▼
Proxmox Host shutdown
          │
          ▼
UPS powers off
```

This sequence ensures that workloads are stopped gracefully before power is exhausted.

---

# Monitoring Runtime

Shutdown decisions should **never** be based only on battery percentage.

Instead, use:

```
battery.runtime
```

Runtime provides a much more accurate indication of the remaining operating time.

Example:

```
battery.runtime = 420
```

Remaining runtime:

```
420 seconds
```

---

# Recommended Shutdown Threshold

Recommended minimum runtime:

```
300 seconds
```

(5 minutes)

This provides enough time for:

- VM shutdown
- Container shutdown
- Filesystem synchronization
- Host shutdown

Large environments may require a higher threshold.

---

# Example NUT Configuration

Example from:

```text
/etc/nut/upsmon.conf
```

```ini
MONITOR ups@localhost 1 admin StrongPassword primary

MINSUPPLIES 1

SHUTDOWNCMD "/sbin/shutdown -h now"

POWERDOWNFLAG /etc/killpower
```

NUT monitors battery status continuously and initiates shutdown when required.

---

# Proxmox Shutdown Workflow

A recommended production workflow is:

1. Detect utility power failure.
2. Continue operating while sufficient runtime remains.
3. Notify administrators.
4. Shutdown virtual machines.
5. Shutdown Linux containers.
6. Shutdown the Proxmox host.
7. Power off the UPS.

This minimizes the risk of data corruption.

---

# Virtual Machine Shutdown

Virtual machines should always be stopped gracefully.

Examples:

```bash
qm shutdown <VMID>
```

Example:

```bash
qm shutdown 100
```

Repeat for every running VM.

---

# Linux Container Shutdown

Containers can also be shut down gracefully.

Example:

```bash
pct shutdown <CTID>
```

Example:

```bash
pct shutdown 101
```

---

# Shutdown Delay

Allow sufficient time for workloads to stop cleanly.

Typical values:

| Environment | Delay |
|-------------|-------|
| Home Lab | 30 seconds |
| Small Office | 60 seconds |
| Enterprise | 120–300 seconds |

The required delay depends on workload complexity.

---

# Host Shutdown

Once all workloads have stopped:

```bash
shutdown -h now
```

or

```bash
systemctl poweroff
```

The host should always be the final system to shut down.

---

# UPS Power-Off

Many USB HID-compatible UPS devices support automatic power-off after the operating system has completed shutdown.

Support depends on:

- UPS manufacturer
- NUT driver
- Firmware capabilities

Always verify functionality before deploying in production.

---

# Testing

Automatic shutdown should always be tested.

Recommended procedure:

- Disconnect utility power.
- Observe UPS transition.
- Verify runtime reporting.
- Confirm alerts.
- Verify VM shutdown.
- Verify container shutdown.
- Verify host shutdown.
- Confirm UPS behavior.

Testing should be repeated after significant infrastructure changes.

---

# Recovery

After utility power returns:

1. UPS returns to Online mode.
2. Proxmox host starts.
3. Virtual machines start according to boot order.
4. Zabbix resumes monitoring.
5. Alerts automatically recover.

Ensure that automatic VM startup is configured if required.

---

# Best Practices

For production environments:

- Base shutdown decisions on runtime rather than battery percentage.
- Leave sufficient safety margin.
- Test shutdown procedures regularly.
- Document shutdown order.
- Keep NUT updated.
- Monitor battery health continuously.
- Replace aging batteries proactively.

---

# Summary

Automatic shutdown is an essential component of any professional UPS deployment.

By combining Network UPS Tools with Proxmox and Zabbix, administrators can ensure that power failures result in controlled shutdowns rather than unexpected outages and potential data loss.

A well-tested shutdown strategy significantly improves infrastructure resilience and should be considered a standard practice in every production environment.

---

**Previous:** [← Proxmox Integration](12-proxmox-integration.md)

**Next:** [Troubleshooting →](14-troubleshooting.md)
