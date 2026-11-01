#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

op=$(echo -e " Mirror\n Set Output\n Set Region\n Unset Region\n Set Scaling\n Toggle Freeze\n Custom" |
  wofi -i --dmenu \
    -c $SCRIPT_DIR/../config \
    -s $SCRIPT_DIR/style.css |
  cut -d' ' -f2- | tr 'A-Z ' 'a-z-')

case $op in
mirror | set-output | set-region | unset-region | set-scaling | toggle-freeze | custom)
  WL_PRESENT_DMENU="wofi -i --dmenu -c $SCRIPT_DIR/../config -s $SCRIPT_DIR/style.css" \
    wl-present "$op"
  ;;
esac
