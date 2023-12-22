#!/bin/bash

# Get the list of sink names and store them in an array
readarray -t sinks < <(pactl list short sinks | cut -f2)

# Get the current default sink name
current_sink=$(pactl info | grep 'Default Sink' | cut -d' ' -f3)

# Find the index of the current sink in the array
current_sink_index=-1
for i in "${!sinks[@]}"; do
	if [ "${sinks[$i]}" == "$current_sink" ]; then
		current_sink_index=$i
		break
	fi
done

# If the current sink was not found or there's only one sink, exit the script
if [ "$current_sink_index" -eq -1 ] || [ "${#sinks[@]}" -eq 1 ]; then
	echo "Cannot cycle sinks."
	exit 1
fi

# Calculate the index of the next sink
next_sink_index=$(((current_sink_index + 1) % ${#sinks[@]}))

# Set the default sink to the next one
pactl set-default-sink "${sinks[$next_sink_index]}"

# Move all audio streams to the new sink
pactl list short sink-inputs | cut -f1 | while read -r stream; do
	pactl move-sink-input "$stream" "${sinks[$next_sink_index]}"
done

echo "Switched to sink: ${sinks[$next_sink_index]}"
