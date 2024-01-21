#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

op=$(echo -e " Lock\n⭘ Suspend\n󰜉 Restart\n󰐥 Poweroff" |
	wofi -i --dmenu \
		-c $SCRIPT_DIR/config \
		-s $SCRIPT_DIR/style.css |
	awk '{print tolower($2)}')

case $op in
poweroff)
	notify-send "System" "Shutting Down" \
		-i $SCRIPT_DIR\gear.png \
		-h string:x-canonical-private-synchronous:powermenu-notif &
	systemctl poweroff
	;&
restart)
	notify-send "System" "Restarting" \
		-i $SCRIPT_DIR\gear.png \
		-h string:x-canonical-private-synchronous:powermenu-notif &
	systemctl reboot
	;&
suspend)
	notify-send "System" "Exiting Sway" \
		-i $SCRIPT_DIR\gear.png \
		-h string:x-canonical-private-synchronous:powermenu-notif &
	swaymsg exit
	;;
lock)
	notify-send "System" "Swaylock" \
		-i $SCRIPT_DIR\gear.png \
		-h string:x-canonical-private-synchronous:powermenu-notif &
	swaylock -c 000000ff \
		--inside-wrong-color 000000ff \
		--inside-clear-color 000000ff \
		--inside-ver-color 000000ff \
		--ring-wrong-color 9c283cff \
		--ring-ver-color 3827cfff \
		--ring-clear-color ffffffff \
		-i /home/$USER/Pictures/Wallpapers/w14.png
	;;
esac
