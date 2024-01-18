#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"
selected=$(echo -e $entries | wofi --dmenu -c $SCRIPT_DIR/config \
	-s $SCRIPT_DIR/style.css \
	--cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
logout)
	exec swaylock -c 000000ff
	;;
suspend)
	exec swaymsg exit
	;;
reboot)
	exec systemctl reboot
	;;
shutdown)
	exec ddcutil setvcp D6 5
	systemctl poweroff
	;;
	# it used to be poweroff -i
esac
