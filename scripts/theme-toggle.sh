#!/bin/bash

### Config File Paths
# Neovim
nvim_options_path="/home/$USER/.config/nvim/lua/config/options.lua"
nvim_colorscheme_path="/home/$USER/.config/nvim/lua/plugins/colorscheme.lua"
nvim_light_theme="onedark"
nvim_dark_theme='tokyonight'
# PDF Readers
okularpartrc_path="/home/$USER/.config/okularpartrc"
zathurarc_path="/home/$USER/.config/zathura/zathurarc"
sioyek_prefs_path="/home/$USER/.config/sioyek/prefs_user.config"

### Argument Parse
# If no argument is passed, toggle the theme
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
  # Global
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

  # Neovim Setting
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "colorscheme ${nvim_light_theme} | set background=light"
  done
  sed -i 's/vim.go.background = "dark"/vim.go.background = "light"/' "$nvim_options_path"
  sed -i 's/colorscheme = "tokyonight"/colorscheme = "onedark"/' "$nvim_colorscheme_path"

  # Pdf Readers
  sed -i '/^startup_commands toggle_custom_color/d' "$sioyek_prefs_path"
  sed -i 's/set recolor true/set recolor false/' "$zathurarc_path"
  sed -i '/ChangeColors=true/d' "$okularpartrc_path"

  # Notification
  echo "Light Theme Set"
  notify-send "System Theme" "Light Mode Set" \
    -h string:x-canonical-private-synchronous:yambar-ddcutil-notification &
}

set_dark_theme() {
  # Global
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

  # Neovim Setting
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "colorscheme ${nvim_dark_theme} | set background=dark"
  done
  sed -i 's/vim.go.background = "light"/vim.go.background = "dark"/' "$nvim_options_path"
  sed -i 's/colorscheme = "onedark"/colorscheme = "tokyonight"/' "$nvim_colorscheme_path"

  # Pdf Readers
  echo "startup_commands toggle_custom_color" >>"$sioyek_prefs_path"
  sed -i 's/set recolor false/set recolor true/' "$zathurarc_path"
  sed -i '/\[Document\]/a ChangeColors=true' "$okularpartrc_path"

  # Notification
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
