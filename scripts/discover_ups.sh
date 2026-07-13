#!/bin/bash

echo "========================================"
echo "USB UPS Discovery"
echo "========================================"

echo
echo "Detected USB devices:"
echo

lsusb

echo

echo "Running NUT Scanner..."
echo

nut-scanner

echo

echo "Configured UPS devices:"
echo

upsc -l
