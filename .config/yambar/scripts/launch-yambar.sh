#!/bin/bash

killall yambar

# Check if wlr-randr is available
if type "wlr-randr" >/dev/null; then
	# Use wlr-randr to get connected displays
	for m in $(wlr-randr | grep 'Enabled: yes' -B1 | grep -oP '^\S+'); do
		# Extract the monitor name and launch yambar for it
		MONITOR=$m yambar &
	done
else
	# Fallback notification if wlr-randr is not available
	notify-send "wlr-randr not found"
fi
