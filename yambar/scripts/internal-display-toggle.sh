#!/bin/bash

output="eDP-1"

sway output "$output" toggle

if [[ "$(swaymsg -t get_outputs | jq -r ".[] | select(.name == \"$output\") | .active")" == "true" ]]; then
  state="Enabled"
else
  state="Disabled"
fi

notify-send "Display" "Internal display $state" \
  -h string:x-canonical-private-synchronous:yambar-display-notification &

"$HOME/.config/yambar/scripts/launch-yambar.sh" &
