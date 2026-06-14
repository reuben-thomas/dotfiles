#!/bin/bash
# Apply the Zathura theme: update config and any running instances.
# Usage: zathura.sh <light|dark>

THEME=$1

ZATHURARC_PATH="$HOME/.config/zathura/zathurarc"

# Re-run the recolor command in each live Zathura instance over D-Bus.
# $1: "true" to enable recoloring (dark), "false" to disable (light).
apply_running() {
  for name in $(busctl --user list --no-pager 2>/dev/null | awk '$1 ~ /^org\.pwmt\.zathura\.PID-[0-9]+$/ {print $1}'); do
    dbus-send --session --dest="$name" --type=method_call \
      /org/pwmt/zathura org.pwmt.zathura.ExecuteCommand \
      string:"set recolor $1" >/dev/null 2>&1
  done
}

case "$THEME" in
light)
  sed -i 's/set recolor true/set recolor false/' "$ZATHURARC_PATH"
  apply_running false
  ;;
dark)
  sed -i 's/set recolor false/set recolor true/' "$ZATHURARC_PATH"
  apply_running true
  ;;
esac
