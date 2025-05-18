#!/bin/bash

# Theme Names
LIGHT_THEME_NAME="light"
DARK_THEME_NAME="dark"

# Global Theme Settings
LIGHT_GTK_THEME="Adwaita"
DARK_GTK_THEME="Adwaita-dark"
LIGHT_COLOR_SCHEME="prefer-light"
DARK_COLOR_SCHEME="prefer-dark"

# Neovim Settings
NVIM_CONFIG_DIR="/home/$USER/.config/nvim"
NVIM_OPTIONS_PATH="$NVIM_CONFIG_DIR/lua/config/options.lua"
NVIM_COLORSCHEME_PATH="$NVIM_CONFIG_DIR/lua/plugins/colorscheme.lua"
NVIM_LIGHT_THEME="onedark"
NVIM_DARK_THEME="tokyonight"

# PDF Reader Settings
CONFIG_DIR="/home/$USER/.config"
OKULARPARTRC_PATH="$CONFIG_DIR/okularpartrc"
ZATHURA_CONFIG_DIR="$CONFIG_DIR/zathura"
ZATHURARC_PATH="$ZATHURA_CONFIG_DIR/zathurarc"
SIOYEK_CONFIG_DIR="$CONFIG_DIR/sioyek"
SIOYEK_PREFS_PATH="$SIOYEK_CONFIG_DIR/prefs_user.config"

# Notification Settings
NOTIFICATION_TITLE="System Theme"
NOTIFICATION_SYNC_KEY="yambar-ddcutil-notification"

### Argument Parse
# If no argument is passed, toggle the theme
if [ "$#" -ne 1 ]; then
  CURRENT_THEME=$(gsettings get org.gnome.desktop.interface color-scheme)
  if [ "$CURRENT_THEME" = "'$DARK_COLOR_SCHEME'" ]; then
    THEME=$LIGHT_THEME_NAME
  else
    THEME=$DARK_THEME_NAME
  fi
else
  THEME=$1
fi

set_light_theme() {
  # Global
  gsettings set org.gnome.desktop.interface color-scheme "$LIGHT_COLOR_SCHEME"
  gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_GTK_THEME"

  # Neovim Setting
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "colorscheme ${NVIM_LIGHT_THEME} | set background=light"
  done
  sed -i 's/vim.go.background = "dark"/vim.go.background = "light"/' "$NVIM_OPTIONS_PATH"
  sed -i "s/colorscheme = \"$NVIM_DARK_THEME\"/colorscheme = \"$NVIM_LIGHT_THEME\"/" "$NVIM_COLORSCHEME_PATH"

  # Pdf Readers
  sed -i '/^startup_commands toggle_custom_color/d' "$SIOYEK_PREFS_PATH"
  sed -i 's/set recolor true/set recolor false/' "$ZATHURARC_PATH"
  sed -i '/ChangeColors=true/d' "$OKULARPARTRC_PATH"

  # Notification
  echo "Light Theme Set"
  notify-send "$NOTIFICATION_TITLE" "Light Mode Set" \
    -h string:x-canonical-private-synchronous:$NOTIFICATION_SYNC_KEY &
}

set_dark_theme() {
  # Global
  gsettings set org.gnome.desktop.interface color-scheme "$DARK_COLOR_SCHEME"
  gsettings set org.gnome.desktop.interface gtk-theme "$DARK_GTK_THEME"

  # Neovim Setting
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "colorscheme ${NVIM_DARK_THEME} | set background=dark"
  done
  sed -i 's/vim.go.background = "light"/vim.go.background = "dark"/' "$NVIM_OPTIONS_PATH"
  sed -i "s/colorscheme = \"$NVIM_LIGHT_THEME\"/colorscheme = \"$NVIM_DARK_THEME\"/" "$NVIM_COLORSCHEME_PATH"

  # Pdf Readers
  echo "startup_commands toggle_custom_color" >>"$SIOYEK_PREFS_PATH"
  sed -i 's/set recolor false/set recolor true/' "$ZATHURARC_PATH"
  sed -i '/\[Document\]/a ChangeColors=true' "$OKULARPARTRC_PATH"

  # Notification
  echo "Dark Theme Set"
  notify-send "$NOTIFICATION_TITLE" "Dark Mode Set" \
    -h string:x-canonical-private-synchronous:$NOTIFICATION_SYNC_KEY &
}

case $THEME in
$LIGHT_THEME_NAME)
  set_light_theme
  ;;
$DARK_THEME_NAME)
  set_dark_theme
  ;;
*)
  echo "Invalid argument. Please use '$LIGHT_THEME_NAME' or '$DARK_THEME_NAME'."
  exit 1
  ;;
esac

exit 0
