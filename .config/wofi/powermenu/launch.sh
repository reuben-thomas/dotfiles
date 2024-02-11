#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

op=$(echo -e " Lock\n⭘ Suspend\n Windows\n󰜉 Reload\n Restart\n󰐥 Poweroff" |
	wofi -i --dmenu \
		-c $SCRIPT_DIR/config \
		-s $SCRIPT_DIR/style.css |
	awk '{print tolower($2)}')

case $op in
poweroff)
	notify-send "System" "Shutting Down" \
		-i $SCRIPT_DIR\gear.png \
		-h string:x-canonical-private-synchronous:powermenu-notif &
	ddcutil setvcp D6 05
	systemctl poweroff
	;&
restart)
	notify-send "System" "Restarting" \
		-i $SCRIPT_DIR\gear.png \
		-h string:x-canonical-private-synchronous:powermenu-notif &
	systemctl reboot
	;&
windows)
	notify-send "System" "Restarting into  Windows 11" \
		-i $SCRIPT_DIR\gear.png \
		-h string:x-canonical-private-synchronous:powermenu-notif
	;;
reload)
	notify-send "System" "Reloading Sway" \
		-i $SCRIPT_DIR\gear.png \
		-h string:x-canonical-private-synchronous:powermenu-notif &
	swaymsg reload
	;;
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
		--text-color 00000000 \
		--text-clear-color 00000000 \
		--text-wrong-color 00000000 \
		--text-ver-color 00000000 \
		--ring-wrong-color 9c283cff \
		--ring-ver-color 3827cfff \
		--ring-clear-color ffffffff \
		-i /home/$USER/Pictures/Wallpapers/w14.png
	;;
esac
