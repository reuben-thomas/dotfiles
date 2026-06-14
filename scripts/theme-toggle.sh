#!/bin/bash

THEME=$1
LIGHT_THEME_NAME="light"
DARK_THEME_NAME="dark"

# Called: <script> <light|dark>
TOGGLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/theme-toggle"
APP_SCRIPTS=(
  "$TOGGLE_DIR/gtk.sh"
  "$HOME/.config/foot/theme-toggle.sh"
  "$HOME/.config/nvim/theme-toggle.sh"
  "$HOME/.config/zathura/theme-toggle.sh"
  "$TOGGLE_DIR/okular.sh"
)

if [ "$THEME" != "$LIGHT_THEME_NAME" ] && [ "$THEME" != "$DARK_THEME_NAME" ]; then
  echo "Invalid argument. Please use '$LIGHT_THEME_NAME' or '$DARK_THEME_NAME'."
  exit 1
fi

# Execute
for script in "${APP_SCRIPTS[@]}"; do
  if [ -x "$script" ]; then
    "$script" "$THEME"
  else
    echo "Error: $script" >&2
  fi
done

# Notification
echo "${THEME^} Theme Set"
notify-send "System Theme" "${THEME^} Mode Set" \
  -h string:x-canonical-private-synchronous:theme-toggle &

exit 0
