#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 [light|dark]"
	exit 1
fi

THEME=$1

set_light_theme() {
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
	for server in $(nvr --serverlist); do
		nvr --servername "$server" -cc 'set background=light'
	done
	echo "Light Theme Set"
	notify-send "System Theme" "Light Mode Set" \
		-h string:x-canonical-private-synchronous:yambar-ddcutil-notification &
}

# Function to set dark theme
set_dark_theme() {
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	for server in $(nvr --serverlist); do
		nvr --servername "$server" -cc 'set background=dark'
	done
	echo "Dark Theme Set"
	notify-send "System Theme" "Dark Mode Set" \
		-h string:x-canonical-private-synchronous:yambar-ddcutil-notification &
}

case $THEME in
light)
	set_light_theme
	;;
dark)
	set_dark_theme
	;;
*)
	echo "Invalid argument. Please use 'light' or 'dark'."
	exit 1
	;;
esac

exit 0
