#!/bin/bash
outputs=$(swaymsg -t get_outputs -r | jq -r '
    [ .[] | select(.active)
      | "\(.name) \(.current_mode.width)x\(.current_mode.height)@\(.current_mode.refresh / 1000 | round)Hz ×\(.scale)"
    ] | join(", ")')
echo "Display: ${outputs:-none}"
