#!/bin/bash

THEME=$1

NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_OPTIONS_PATH="$NVIM_CONFIG_DIR/lua/config/options.lua"
NVIM_COLORSCHEME_PATH="$NVIM_CONFIG_DIR/lua/plugins/colorscheme.lua"
NVIM_LIGHT_THEME="onedark"
NVIM_DARK_THEME="tokyonight"

case "$THEME" in
light)
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "colorscheme ${NVIM_LIGHT_THEME} | set background=light"
  done
  sed -i 's/vim.go.background = "dark"/vim.go.background = "light"/' "$NVIM_OPTIONS_PATH"
  sed -i "s/colorscheme = \"$NVIM_DARK_THEME\"/colorscheme = \"$NVIM_LIGHT_THEME\"/" "$NVIM_COLORSCHEME_PATH"
  ;;
dark)
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "colorscheme ${NVIM_DARK_THEME} | set background=dark"
  done
  sed -i 's/vim.go.background = "light"/vim.go.background = "dark"/' "$NVIM_OPTIONS_PATH"
  sed -i "s/colorscheme = \"$NVIM_LIGHT_THEME\"/colorscheme = \"$NVIM_DARK_THEME\"/" "$NVIM_COLORSCHEME_PATH"
  ;;
*)
  echo "Usage: $(basename "$0") <light|dark>" >&2
  exit 1
  ;;
esac
