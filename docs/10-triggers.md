# Triggers

## Overview

Collecting UPS metrics is only the first step in building an effective monitoring solution.

The real value comes from **triggers**, which automatically detect abnormal conditions and notify administrators before a minor issue becomes a service interruption.

This repository includes a recommended set of production-ready triggers suitable for most Linux, Proxmox, and enterprise environments.

---

# Trigger Philosophy

An effective monitoring system should:

- Detect problems early
- Reduce false positives
- Generate actionable alerts
- Differentiate between warning and critical events
- Avoid unnecessary notification storms

Every trigger should answer a simple question:

> **Does this event require administrator attention?**

---

# Trigger Severity

The following severity levels are recommended.

| Severity | Purpose |
|----------|---------|
| Information | Informational events |
| Warning | Potential issues |
| Average | Reduced redundancy or degraded operation |
| High | Immediate administrator action required |
| Disaster | Critical infrastructure failure |

---

# Recommended Triggers

## UPS Running on Battery

**Severity**

Average

**Condition**

```text
UPS Status = OB
```

Description:

The UPS has switched to battery mode.

This usually indicates a utility power failure.

---

## Low Battery Charge

**Severity**

High

**Condition**

```text
Battery Charge < {$UPS.BATTERY.LOW}
```

Recommended default:

```
20%
```

Description:

Battery capacity has dropped below the configured threshold.

---

## Critical Battery Runtime

**Severity**

High

**Condition**

```text
Battery Runtime < {$UPS.RUNTIME.MIN}
```

Recommended default:

```
300 seconds
```

Description:

The UPS may no longer be able to keep connected equipment running.

---

## UPS Communication Lost

**Severity**

High

Description:

The Zabbix Agent can no longer retrieve information from Network UPS Tools.

Possible causes include:

- USB cable disconnected
- NUT service stopped
- UPS powered off
- Driver failure

---

## UPS Overload

**Severity**

Warning

Condition:

```text
UPS Load > {$UPS.LOAD.MAX}
```

Recommended default:

```
80%
```

Description:

The UPS is operating close to its maximum capacity.

Reducing the load will increase battery runtime and improve reliability.

---

## Replace Battery

**Severity**

Average

Condition:

```text
UPS Status contains RB
```

Description:

The UPS has reported that the battery should be replaced.

Battery replacement should not be delayed.

---

## Utility Power Restored

**Severity**

Information

Condition:

```text
UPS Status = OL
```

Description:

The UPS has returned to normal online operation.

---

## Battery Charging

**Severity**

Information

Condition:

```text
UPS Status contains CHRG
```

Description:

The UPS battery is currently charging after a discharge event.

---

## Battery Temperature High

**Severity**

Warning

Condition:

```text
Battery Temperature > {$UPS.TEMP.MAX}
```

Recommended default:

```
40°C
```

This trigger only applies if the UPS reports battery temperature.

---

## Low Input Voltage

**Severity**

Warning

Condition:

```text
Input Voltage < {$UPS.INPUT.MIN}
```

Recommended threshold:

```
200V
```

Low utility voltage may indicate electrical problems.

---

## High Input Voltage

**Severity**

Warning

Condition:

```text
Input Voltage > {$UPS.INPUT.MAX}
```

Recommended threshold:

```
250V
```

Unexpectedly high voltage should be investigated.

---

# Recovery Conditions

Whenever possible, triggers should automatically recover when the monitored value returns to a healthy state.

Example:

```
UPS Status

OB → OL
```

The trigger closes automatically once utility power has been restored.

---

# Trigger Dependencies

To reduce duplicate alerts, trigger dependencies are recommended.

Example:

```
Power Failure
        │
        ├── Low Battery
        ├── Runtime Critical
        └── UPS Overload
```

This prevents multiple notifications for the same root cause.

---

# Recommended Macros

| Macro | Default |
|---------|---------|
| {$UPS.BATTERY.LOW} | 20 |
| {$UPS.RUNTIME.MIN} | 300 |
| {$UPS.LOAD.MAX} | 80 |
| {$UPS.INPUT.MIN} | 200 |
| {$UPS.INPUT.MAX} | 250 |
| {$UPS.TEMP.MAX} | 40 |

Using macros allows thresholds to be adjusted without modifying the template.

---

# Alert Examples

Recommended notifications include:

- Email
- Microsoft Teams
- Slack
- Telegram
- SMS
- Webhook integrations

Alerting should be handled by Zabbix Actions rather than individual triggers.

---

# Best Practices

For production environments:

- Avoid excessive trigger sensitivity.
- Use macros instead of hardcoded values.
- Configure trigger dependencies.
- Test notifications regularly.
- Review historical trigger events.
- Keep thresholds consistent across environments.

---

# Summary

Triggers transform raw UPS metrics into actionable operational intelligence.

By combining well-designed thresholds, trigger dependencies, and centralized alerting, administrators can detect power-related issues early and respond before they impact production services.

---

**Previous:** [← UserParameters](09-userparameters.md)

**Next:** [Low Level Discovery (LLD) →](11-lld-discovery.md)
