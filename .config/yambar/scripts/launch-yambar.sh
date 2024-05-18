#!/bin/bash

killall yambar
outputs=$(swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name + "," + (.rect.width | tostring)')

while IFS=, read -r name width; do
	echo $name
	if [ "$width" -ge 1900 ]; then
		sed -i "s/^  monitor:.*/  monitor: $name/" "/home/reuben/.config/yambar/config.yml"
		yambar -c "/home/reuben/.config/yambar/config.yml" &
	else
		sed -i "s/^  monitor:.*/  monitor: $name/" "/home/reuben/.config/yambar/minimal.yml"
		yambar -c "/home/reuben/.config/yambar/minimal.yml" &
	fi
	sleep 0.05

done <<<"$outputs"
