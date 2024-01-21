#!/bin/bash

device_list=$(bluetoothctl devices)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

declare -A device_name_to_mac
formatted_device_names=""
while IFS= read -r line; do
	mac_address=$(echo "$line" | awk '{print $2}')
	device_name=$(echo "$line" | awk '{$1=$2=""; print substr($0,3)}')
	device_name_to_mac[$device_name]=$mac_address
	formatted_device_names+="${device_name}\n"
done <<<"$device_list"
formatted_device_names=$(echo -e "$formatted_device_names" | head -n -1)

for key in "${!device_name_to_mac[@]}"; do echo "$key - ${device_name_to_mac[$key]}"; done

selected_device=$(echo -e "$formatted_device_names" |
	wofi -i --dmenu \
		-c $SCRIPT_DIR/config \
		-s $SCRIPT_DIR/style.css)

selected_mac="${device_name_to_mac[$selected_device]}"

if [ -n "$selected_mac" ]; then
	is_connected=$(bluetoothctl info "$selected_mac" | grep "Connected: yes")
	if [ -n "$is_connected" ]; then
		bluetoothctl disconnect "$selected_mac"
		echo "Disconnected $selected_device"
		notify-send "Bluetooth Devices" "Disconnected from $selected_device" \
			-h string:x-canonical-private-synchronous:bt-device-menu &
	else
		bluetoothctl connect "$selected_mac"
		echo "Connected $selected_device"
		notify-send "Bluetooth Devices" "Connected to $selected_device" \
			-h string:x-canonical-private-synchronous:bt-device-menu &
	fi
else
	echo "Device not found."
fi
