#!/bin/bash

killall yambar
outputs=$(swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name + "," + (.rect.width | tostring) + "," + (.scale | tostring)')

while IFS=, read -r name width scale; do
  echo $name
  echo $scale

  if [[ "$name" == "HEADLESS-1" ]]; then
    continue
  else
    sed -i "s/^  monitor:.*/  monitor: $name/" "$HOME/.config/yambar/config.yml"
    yambar -c "$HOME/.config/yambar/config.yml" &
  fi
  sleep 0.25

done <<<"$outputs"
