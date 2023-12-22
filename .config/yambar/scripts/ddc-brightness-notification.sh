#!/bin/bash

notification_text=""
max_displays=3

adjust_brightness() {
	display=$1
	mode=$2
	case $mode in
	0) ddcutil -d $display setvcp 10 - 20 --noverify ;;
	1) ddcutil -d $display setvcp 10 40 --noverify ;;
	2) ddcutil -d $display setvcp 10 + 20 --noverify ;;
	esac
}

get_current_brightness() {
	brightness_info=$(ddcutil -d "$1" getvcp 10 2>/dev/null)
	echo "$brightness_info" | grep "current value" | awk -F' =   ' '{print $2}' | cut -d ',' -f 1
}

# Get display information
readarray -t display_info < <(ddcutil detect | grep -E "Display [0-$max_displays]+|Model:")

# Process each display
for ((i = 0; i < ${#display_info[@]}; i += 2)); do
	if [[ ${display_info[$i]} =~ ^Display\ [0-9]+ ]]; then
		display_number=$(echo "${display_info[$i]}" | grep -o -E '[0-9]+')
		model_name=$(echo "${display_info[$i + 1]}" | sed 's/^[[:space:]]*Model:[[:space:]]*//')

		adjust_brightness "$display_number" "$1"
		current_brightness=$(get_current_brightness "$display_number")
		notification_text+="$model_name: $current_brightness%\n"
	fi
done

# Check if notification_text is not empty
if [[ -n $notification_text ]]; then
	# Send a single notification with all monitor info
	notify-send "Monitor Brightness" "$notification_text" \
		-h string:x-canonical-private-synchronous:yambar-ddcutil-notification &
else
	notify-send "Monitor Brightness" "No DDC/CI compatible display detected" \
		-h string:x-canonical-private-synchronous:yambar-ddcutil-notification &
fi
