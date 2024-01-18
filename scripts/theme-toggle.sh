#!/bin/bash

# If no argument provided, just toggle
if [ "$#" -ne 1 ]; then
	CURRENT_THEME=$(gsettings get org.gnome.desktop.interface color-scheme)
	if [ "$CURRENT_THEME" = "'prefer-dark'" ]; then
		THEME='light'
	else
		THEME='dark'
	fi
else
	THEME=$1
fi

set_light_theme() {
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
	for server in $(nvr --serverlist); do
		nvr --servername "$server" -cc 'colorscheme tokyonight | set background=light'
	done
	echo "Light Theme Set"
	notify-send "System Theme" "Light Mode Set" \
		-h string:x-canonical-private-synchronous:yambar-ddcutil-notification &
}

set_dark_theme() {
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	for server in $(nvr --serverlist); do
		nvr --servername "$server" -cc 'colorscheme onedark | set background=dark'
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
