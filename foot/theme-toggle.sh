#!/bin/bash

THEME=$1

FOOT_CONFIG_DIR="$HOME/.config/foot"

echo "$THEME" >"$FOOT_CONFIG_DIR/current_theme"
for foot_pid in $(pgrep -x foot); do
  for child in $(pgrep -P "$foot_pid"); do
    tty=$(ps -o tty= -p "$child" 2>/dev/null)
    case "$tty" in
    pts/*)
      dev="/dev/$tty"
      echo "foot $foot_pid -> child $child -> $dev" >&2
      [ -w "$dev" ] && "$FOOT_CONFIG_DIR/set-theme.sh" >"$dev" 2>/dev/null
      ;;
    esac
  done
done
