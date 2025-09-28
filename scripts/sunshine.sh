if ! swaymsg -t get_outputs | grep -q "HEADLESS-1"; then
  swaymsg create_output HEADLESS-1
  swaymsg output HEADLESS-1 mode 2048x1536@30Hz
fi
sunshine
