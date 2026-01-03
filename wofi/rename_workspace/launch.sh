!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

new_ws_name=$(wofi -i --dmenu \
  -c "$SCRIPT_DIR/config" \
  -s "$SCRIPT_DIR/style.css" \
  -p "Search:")

~/.config/scripts/sway-rename-ws.sh "$new_ws_name"
