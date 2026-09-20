#!/bin/bash

unit="lid-inhibit"

if systemctl --user is-active --quiet "$unit"; then
	systemctl --user stop "$unit"
	notify-send "Lid Sleep" "Enabled" \
		-h string:x-canonical-private-synchronous:sleep-toggle-notification &
else
	if systemd-run --user --unit="$unit" --quiet --collect \
		systemd-inhibit --what=handle-lid-switch --mode=block \
		--who="toggle-sleep" --why="User requested" \
		sleep infinity; then
		notify-send "Lid Sleep" "Disabled" \
			-h string:x-canonical-private-synchronous:sleep-toggle-notification &
	else
		notify-send "Lid Sleep Error" "Could not inhibit the lid switch"
	fi
fi
