#!/bin/bash

echo "========================================"
echo "Checking Network UPS Tools"
echo "========================================"

echo
echo "Configured UPS devices:"
echo

upsc -l

echo

for UPS in $(upsc -l)
do
    echo "----------------------------------------"
    echo "$UPS"
    echo "----------------------------------------"

    upsc "$UPS"

    echo
done
