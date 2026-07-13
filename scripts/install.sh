#!/bin/bash

echo "========================================"
echo " Zabbix NUT UPS Monitoring Installer"
echo "========================================"

echo
echo "Updating package lists..."
apt update

echo
echo "Installing required packages..."

apt install -y \
nut \
nut-client \
nut-server \
nut-scanner \
zabbix-agent

echo
echo "Installation completed."

echo
echo "Installed versions:"
echo

nut-scanner --version

echo

zabbix_agentd --version | head -n 1

echo
echo "Next step:"
echo "Configure NUT using the examples provided in this repository."
