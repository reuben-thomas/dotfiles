#!/bin/bash
if bluetoothctl show | grep -q "Powered: yes"; then
    devices=$(bluetoothctl devices Connected \
        | cut -d' ' -f3- \
        | sed ':a;N;$!ba;s/\n/, /g')
    echo "Bluetooth: ${devices:-on, no devices}"
else
    echo "Bluetooth: off"
fi
