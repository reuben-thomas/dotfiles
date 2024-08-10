#!/bin/bash

file="/sys/module/usbcore/parameters/autosuspend"

current_value=$(cat $file)

if [ "$current_value" == "-1" ]; then
	echo 2 >$file
	notify-send "USB Autosuspend" "Enabled"
	-h string:x-canonical-private-synchronous:yambar-autosuspend-notification &
elif [ "$current_value" == "2" ]; then
	echo -1 >$file
	notify-send "USB Autosuspend" "Disabled" \
		-h string:x-canonical-private-synchronous:yambar-autosuspend-notification &
else
	notify-send "USB Autosuspend Error" "Unexpected value: $current_value"
fi
