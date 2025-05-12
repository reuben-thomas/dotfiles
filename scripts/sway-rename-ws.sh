#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <new_workspace_name>"
  exit 1
fi

new_ws_name="$1"

if eval "swaymsg rename workspace to \"$new_ws_name\""; then
  echo "Renamed current workspace to '$new_ws_name'"
else
  echo "Failed to rename workspace."
  notify-send "Rename Workspace Failed" "Workspace of the same name already exists" \
    -h string:x-canonical-private-synchronous:sway-ws-rename-notification &
  exit 1
fi

exit 0
