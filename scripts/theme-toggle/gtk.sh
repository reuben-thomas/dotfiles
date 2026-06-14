#!/bin/bash
# Apply the global GTK theme and color-scheme.
# Usage: global.sh <light|dark>

THEME=$1

LIGHT_GTK_THEME="Adwaita"
DARK_GTK_THEME="Adwaita-dark"
LIGHT_COLOR_SCHEME="prefer-light"
DARK_COLOR_SCHEME="prefer-dark"

case "$THEME" in
light)
  gsettings set org.gnome.desktop.interface color-scheme "$LIGHT_COLOR_SCHEME"
  gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_GTK_THEME"
  ;;
dark)
  gsettings set org.gnome.desktop.interface color-scheme "$DARK_COLOR_SCHEME"
  gsettings set org.gnome.desktop.interface gtk-theme "$DARK_GTK_THEME"
  ;;
*)
  echo "Usage: $(basename "$0") <light|dark>" >&2
  exit 1
  ;;
esac
