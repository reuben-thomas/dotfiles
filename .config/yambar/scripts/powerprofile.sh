#!/bin/bash

# Get current power profile
current_profile=$(powerprofilesctl get)

# Define the power profiles in order
profiles=("performance" "balanced" "power-saver")

# Find the index of the current profile
for i in "${!profiles[@]}"; do
	if [[ "${profiles[$i]}" = "${current_profile}" ]]; then
		current_index=$i
		break
	fi
done

# Calculate the next profile index
next_index=$(((current_index + 1) % ${#profiles[@]}))

# Set the next power profile
powerprofilesctl set ${profiles[$next_index]}

# Send desktop notification
notify-send "Power Profile" "Switched to ${profiles[$next_index]} mode."
