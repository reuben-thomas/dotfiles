#!/bin/bash

killall yambar

swaylock -c 000000ff \
  --indicator-idle-visible \
  --indicator-radius 70 \
  --indicator-thickness 18 \
  --ring-color e8e8e870 \
  --key-hl-color 722effff \
  --bs-hl-color ff4766ff \
  --ring-ver-color 3cbdf0d1 \
  --ring-wrong-color ff4d4dd1 \
  --ring-clear-color ffffffd1 \
  --inside-color 00000000 \
  --inside-ver-color 00000000 \
  --inside-wrong-color 00000000 \
  --inside-clear-color 00000000 \
  --text-color 00000000 \
  --text-clear-color 00000000 \
  --text-wrong-color 00000000 \
  --text-ver-color 00000000 \
  --line-color 00000000 \
  --line-ver-color 00000000 \
  --line-wrong-color 00000000 \
  --line-clear-color 00000000 \
  --separator-color 00000000 \
  -i $HOME/Pictures/Wallpapers/florence_2.JPG

swaymsg reload
