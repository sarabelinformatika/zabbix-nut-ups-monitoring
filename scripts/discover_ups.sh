#!/usr/bin/env bash

###############################################################################
# Zabbix Low Level Discovery
# Network UPS Tools
###############################################################################

echo '{"data":['

FIRST=true

while read UPS
do
    [ -z "$UPS" ] && continue

    if [ "$FIRST" = true ]; then
        FIRST=false
    else
        echo ","
    fi

    printf '{"{#UPS}":"%s"}' "$UPS"

done < <(upsc -l)

echo "]}"
