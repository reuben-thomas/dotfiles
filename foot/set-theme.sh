current_theme=$(cat "$HOME/.config/foot/current_theme")

if [ "$current_theme" = "dark" ]; then
  # DARK
  # based on outrun-dark, from theme.sh
  # https://github.com/lemnos/theme.sh
  printf "\e]11;#00002a\a" # Background
  printf "\e]10;#d0d0fa\a" # Foreground
  printf "\e]12;#d0d0fa\a" # Cursor

  # Palette 0-7
  printf "\e]4;0;#00002a\a"
  printf "\e]4;1;#ff4242\a"
  printf "\e]4;2;#59f176\a"
  printf "\e]4;3;#f3e877\a"
  printf "\e]4;4;#66b0ff\a"
  printf "\e]4;5;#f10596\a"
  printf "\e]4;6;#0ef0f0\a"
  printf "\e]4;7;#d0d0fa\a"

  # Palette 8-15
  printf "\e]4;8;#50507a\a"
  printf "\e]4;9;#ff4242\a"
  printf "\e]4;10;#59f176\a"
  printf "\e]4;11;#f3e877\a"
  printf "\e]4;12;#66b0ff\a"
  printf "\e]4;13;#f10596\a"
  printf "\e]4;14;#0ef0f0\a"
  printf "\e]4;15;#f5f5ff\a"

elif [ "$current_theme" = "light" ]; then
  # LIGHT
  # based on summerfruit-light, from theme.sh
  #   # https://github.com/lemnos/theme.sh
  printf "\e]11;#ffffff\a" # Background
  printf "\e]10;#101010\a" # Foreground
  printf "\e]12;#101010\a" # Cursor

  # Palette 0-7
  printf "\e]4;0;#ffffff\a"
  printf "\e]4;1;#ff0086\a"
  printf "\e]4;2;#00c918\a"
  printf "\e]4;3;#aba800\a"
  printf "\e]4;4;#3777e6\a"
  printf "\e]4;5;#ad00a1\a"
  printf "\e]4;6;#1faaaa\a"
  printf "\e]4;7;#101010\a"

  # Palette 8-15
  printf "\e]4;8;#b0b0b0\a"
  printf "\e]4;9;#ff0086\a"
  printf "\e]4;10;#00c918\a"
  printf "\e]4;11;#aba800\a"
  printf "\e]4;12;#3777e6\a"
  printf "\e]4;13;#ad00a1\a"
  printf "\e]4;14;#1faaaa\a"
  printf "\e]4;15;#202020\a"
fi
