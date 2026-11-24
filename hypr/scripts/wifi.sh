#!/bin/bash
ssid=$(nmcli -t -f TYPE,STATE,CONNECTION device \
    | grep '^wifi:connected:' \
    | cut -d: -f3-)
echo "Wi-Fi: ${ssid:-disconnected}"
