#!/bin/bash
bat=/sys/class/power_supply/BAT0
profile=$(powerprofilesctl get 2>/dev/null)
echo "Battery: $(cat "$bat/capacity")% ($(cat "$bat/status")) · $(uptime -p) · ${profile:-unknown}"
