#!/bin/bash

THEME=$1

FZFRC_PATH="$HOME/.config/fzf/fzfrc"

case "$THEME" in
light | dark)
  sed -i -E "s/^--color=(light|dark)$/--color=$THEME/" "$FZFRC_PATH"
  ;;
*)
  echo "Usage: $(basename "$0") <light|dark>" >&2
  exit 1
  ;;
esac
