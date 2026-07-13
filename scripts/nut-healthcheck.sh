#!/bin/bash

echo "========================================"
echo "NUT Health Check"
echo "========================================"

echo

echo "Checking NUT services..."
echo

systemctl is-active nut-server

systemctl is-active nut-monitor

echo

echo "Checking Zabbix Agent..."
echo

systemctl is-active zabbix-agent

echo

echo "Checking UPS communication..."
echo

for UPS in $(upsc -l)
do
    echo "----------------------------------------"
    echo "$UPS"
    echo "----------------------------------------"

    upsc "$UPS" | grep -E "ups.status|battery.charge|battery.runtime|ups.load"

    echo
done

echo "Health check completed."
