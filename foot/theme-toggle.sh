#!/bin/bash

THEME=$1

case "$THEME" in
dark) SIG=USR1 ;;
light) SIG=USR2 ;;
*)
  echo "Usage: $(basename "$0") <light|dark>" >&2
  exit 1
  ;;
esac

echo "initial-color-theme=$THEME" >"$HOME/.config/foot/theme.ini"

pkill -"$SIG" -x -u "$USER" foot || true
