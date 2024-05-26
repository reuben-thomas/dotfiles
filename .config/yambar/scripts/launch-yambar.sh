#!/bin/bash

killall yambar
outputs=$(swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name + "," + (.rect.width | tostring) + "," + (.scale | tostring)')

while IFS=, read -r name width scale; do
	echo $name
	echo $scale
	if [ "$width" -ge 2560 ] && (($(echo "$scale > 1.0" | bc -l))); then
		echo HI
		sed -i "s/^  monitor:.*/  monitor: $name/" "/home/reuben/.config/yambar/config.yml"
		yambar -c "/home/reuben/.config/yambar/maximal.yml" &
	elif [ "$width" -ge 1900 ]; then
		sed -i "s/^  monitor:.*/  monitor: $name/" "/home/reuben/.config/yambar/config.yml"
		yambar -c "/home/reuben/.config/yambar/config.yml" &
	else
		sed -i "s/^  monitor:.*/  monitor: $name/" "/home/reuben/.config/yambar/minimal.yml"
		yambar -c "/home/reuben/.config/yambar/minimal.yml" &
	fi
	sleep 0.05

done <<<"$outputs"
