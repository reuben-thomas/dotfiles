#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

current_ws_name=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .name')

new_ws_name=$(wofi -i --dmenu -e \
  -c "$SCRIPT_DIR/config" \
  -s "$SCRIPT_DIR/style.css" \
  -p "Search:" \
  -Q "$current_ws_name" </dev/null)

# Cancelled (Esc) or empty input
if [ -z "$new_ws_name" ]; then
  exit 1
fi

if swaymsg rename workspace to "$new_ws_name"; then
  echo "Renamed current workspace to '$new_ws_name'"
else
  echo "Failed to rename workspace."
  notify-send "Rename Workspace Failed" "Workspace of the same name already exists" \
    -h string:x-canonical-private-synchronous:sway-ws-rename-notification &
  exit 1
fi

exit 0
