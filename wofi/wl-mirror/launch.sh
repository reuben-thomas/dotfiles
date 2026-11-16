#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

op=$(echo -e " Mirror\n Set Output\n Set Region\n Set Window\n Unset Region\n Set Scaling\n Toggle Freeze\n Custom" |
  wofi -i --dmenu \
    -c $SCRIPT_DIR/../config \
    -s $SCRIPT_DIR/style.css |
  cut -d' ' -f2- | tr 'A-Z ' 'a-z-')

case $op in
mirror | set-output | set-region | unset-region | set-scaling | toggle-freeze | custom)
  WL_PRESENT_DMENU="wofi -i --dmenu -c $SCRIPT_DIR/../config -s $SCRIPT_DIR/style.css" \
    wl-present "$op"
  ;;
set-window)
  region=$(swaymsg -t get_tree |
    jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' |
    slurp -r 2>/dev/null) || exit 0
  [[ -n "$region" ]] && wl-present set-region "$region"
  ;;
esac
