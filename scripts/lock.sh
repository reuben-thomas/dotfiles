#!/bin/bash

killall yambar
swaylock -c 000000ff \
  --text-color 00000000 \
  --text-clear-color 00000000 \
  --text-wrong-color 00000000 \
  --text-ver-color 00000000 \
  --ring-wrong-color 9c283cff \
  --ring-ver-color 3827cfff \
  --ring-clear-color ffffffff \
  -i /home/$USER/Pictures/Wallpapers/911airport.jpg
$HOME/.config/yambar/scripts/launch-yambar.sh
