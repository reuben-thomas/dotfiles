#!/bin/bash

THEME=$1

OKULARPARTRC_PATH="$HOME/.config/okularpartrc"

apply_running() {
  for name in $(busctl --user list --no-pager 2>/dev/null | awk '$1 ~ /^org\.kde\.okular-[0-9]+$/ {print $1}'); do
    dbus-send --session --dest="$name" --type=method_call \
      /okular org.kde.okular.slotSetChangeColors boolean:"$1" >/dev/null 2>&1
  done
}

case "$THEME" in
light)
  sed -i '/ChangeColors=true/d' "$OKULARPARTRC_PATH"
  apply_running false
  ;;
dark)
  sed -i '/\[Document\]/a ChangeColors=true' "$OKULARPARTRC_PATH"
  apply_running true
  ;;
*)
  echo "Usage: $(basename "$0") <light|dark>" >&2
  exit 1
  ;;
esac
