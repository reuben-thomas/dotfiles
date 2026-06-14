current_theme=$(cat "$HOME/.config/foot/current_theme")

if [ "$current_theme" = "dark" ]; then
  # DARK
  # based on outrun-dark, from theme.sh
  # https://github.com/lemnos/theme.sh
  printf "\e]11;[85]#0d101b\a" # Background
  printf "\e]10;#ebeef9\a"     # Foreground
  printf "\e]12;#ebeef9\a"     # Cursor

  # Palette 0-7
  printf "\e]4;0;#1c1c1c\a"
  printf "\e]4;1;#ff3d5e\a"
  printf "\e]4;2;#14ff8a\a"
  printf "\e]4;3;#ffce63\a"
  printf "\e]4;4;#58b6ca\a"
  printf "\e]4;5;#6488c4\a"
  printf "\e]4;6;#8d84c6\a"
  printf "\e]4;7;#d0d0fa\a"

  # Palette 8-15
  printf "\e]4;8;#838796\a"
  printf "\e]4;9;#ee829f\a"
  printf "\e]4;10;#a5ffe1\a"
  printf "\e]4;11;#f3e877\a"
  printf "\e]4;12;#8be9fd\a"
  printf "\e]4;13;#97bbf7\a"
  printf "\e]4;14;#c0b7f9\a"
  printf "\e]4;15;#ffffff\a"

elif [ "$current_theme" = "light" ]; then
  # LIGHT
  # based on summerfruit-light, from theme.sh
  # https://github.com/lemnos/theme.sh
  printf "\e]11;[100]#ffffff\a" # Background
  printf "\e]10;#101010\a"      # Foreground
  printf "\e]12;#101010\a"      # Cursor

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
