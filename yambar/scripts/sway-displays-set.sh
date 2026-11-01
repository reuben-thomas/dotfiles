#!/bin/bash

if output=$("$HOME/.cargo/bin/sway-displays" set 2>&1); then
  notify-send "Display" "Loaded display configuration" \
    -h string:x-canonical-private-synchronous:yambar-display-notification &
else
  notify-send -u critical "Display Error" "Failed to load display configuration\n$output" \
    -h string:x-canonical-private-synchronous:yambar-display-notification &
fi
