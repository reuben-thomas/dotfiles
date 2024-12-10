#!/bin/bash

readarray -t sources < <(pactl list short sources | cut -f2)
current_source=$(pactl info | grep 'Default Source' | cut -d' ' -f3)
echo $current_source

current_source_index=-1
for i in "${!sources[@]}"; do
  if [ "${sources[$i]}" == "$current_source" ]; then
    current_source_index=$i
    break
  fi
done

if [ "$current_source_index" -eq -1 ] || [ "${#sources[@]}" -eq 1 ]; then
  notify-send "System" "No other inputs detected" -h string:x-canonical-private-synchronous:yambar-sink-notification &
  exit 1
fi

next_source_index=$(((current_source_index + 1) % ${#sources[@]}))

pactl set-default-source "${sources[$next_source_index]}"

pactl list short source-outputs | cut -f1 | while read -r stream; do
  pactl move-source-output "$stream" "${sources[$next_source_index]}"
done

echo "Switched to source: ${sources[$next_source_index]}"
