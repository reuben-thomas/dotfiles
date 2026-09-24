#!/bin/bash

THEME=$1

NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_OPTIONS_PATH="$NVIM_CONFIG_DIR/lua/config/options.lua"
NVIM_COLORSCHEME_PATH="$NVIM_CONFIG_DIR/lua/plugins/colorscheme.lua"
NVIM_LIGHT_THEME="onenord"
NVIM_DARK_THEME="onedark"
# onedark latches style='light' the moment it (re)loads while background=light,
# and never recovers on its own, so the dark switch has to re-assert the style
# from colorscheme.lua rather than just running :colorscheme.
NVIM_DARK_STYLE="$(grep -oP 'style = "\K[^"]+' "$NVIM_COLORSCHEME_PATH" | head -1)"

case "$THEME" in
light)
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "lua vim.o.background = 'light'; vim.cmd('colorscheme ${NVIM_LIGHT_THEME}')"
  done
  sed -i 's/vim.go.background = "dark"/vim.go.background = "light"/' "$NVIM_OPTIONS_PATH"
  sed -i "s/colorscheme = \"$NVIM_DARK_THEME\"/colorscheme = \"$NVIM_LIGHT_THEME\"/" "$NVIM_COLORSCHEME_PATH"
  ;;
dark)
  for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc "lua vim.o.background = 'dark'; require('onedark').setup({ style = '${NVIM_DARK_STYLE}' }); vim.cmd('colorscheme ${NVIM_DARK_THEME}')"
  done
  sed -i 's/vim.go.background = "light"/vim.go.background = "dark"/' "$NVIM_OPTIONS_PATH"
  sed -i "s/colorscheme = \"$NVIM_LIGHT_THEME\"/colorscheme = \"$NVIM_DARK_THEME\"/" "$NVIM_COLORSCHEME_PATH"
  ;;
*)
  echo "Usage: $(basename "$0") <light|dark>" >&2
  exit 1
  ;;
esac
