#!/bin/bash

battery_percentage=$(acpi -b | grep -P -o '[0-9]+(?=%)' | sort | tail -1)
charger_online=$(acpi -b | grep -c "Charging")

if [[ $charger_online -eq 1 && $battery_percentage -gt 80 ]]; then
	export DISPLAY=:0.0
	--app-name "user-script" \
		--expire-time=300000 \
		--app-id "scripts" \
		"󰂄 Unplug Charger" "Level: ${battery_percentage}%" \
		-h string:x-canonical-private-synchronous:yambar-battery-check &
fi

if [[ $charger_online -eq 0 && $battery_percentage -lt 20 ]]; then
	export DISPLAY=:0.0
	notify-send -u critical \
		--expire-time=300000 \
		--app-name "user-script" \
		"󰁺 Low Battery" "Level: ${battery_percentage}%" \
		-h string:x-canonical-private-synchronous:yambar-battery-check &
fi
