#!/bin/bash

current_mode=$(makoctl mode)
if [ "$current_mode" == "dnd" ]; then
  makoctl mode -s default
  notify-send "System" "Notifications Enabled" \
    -h string:x-canonical-private-synchronous:dnd-toggle-notification &
else
  makoctl dismiss -a
  notify-send "System" "Notifications Disabled" \
    -h string:x-canonical-private-synchronous:dnd-toggle-notification &
  sleep 1
  makoctl mode -s dnd
fi
echo ""
