#!/bin/bash

current_mode=$(makoctl mode)
if [ "$current_mode" == "dnd" ]; then
	makoctl mode -s default
	notify-send "System" "Notifications Enabled" \
		-h string:x-canonical-private-synchronous:dnd-toggle-notification &
else
	makoctl mode -s dnd
fi
echo ""
