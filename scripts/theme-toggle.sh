#!/bin/bash

vim_light_theme="onedark"
vim_dark_theme='tokyonight'

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
  # Global
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

  # Neovim Setting
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "colorscheme ${vim_light_theme} | set background=light"
  done
  sed -i 's/vim.go.background = "dark"/vim.go.background = "light"/' \
    /home/$USER/.config/nvim/lua/config/options.lua
  sed -i 's/colorscheme = "tokyonight"/colorscheme = "onedark"/' \
    /home/$USER/.config/nvim/lua/plugins/colorscheme.lua

  # Terminal

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
    nvr --servername "$server" -cc "colorscheme ${vim_dark_theme} | set background=dark"
  done
  sed -i 's/vim.go.background = "light"/vim.go.background = "dark"/' \
    /home/$USER/.config/nvim/lua/config/options.lua
  sed -i 's/colorscheme = "onedark"/colorscheme = "tokyonight"/' \
    /home/$USER/.config/nvim/lua/plugins/colorscheme.lua

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
