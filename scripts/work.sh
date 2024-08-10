#!/bin/bash

sway output eDP-1 disable
primary="'BenQ Corporation BenQ EL2870U A3K00708SL0'"
secondary="'BenQ Corporation BenQ EL2870U A3K00711SL0'"
sway output "$primary" pos 1440 600 scale 1.22 res 3840x2160
sway output "$secondary" pos 0 0 scale 1.22 res 3840x2160 transform 90

# Assign Workspaces
sway workspace music output "$secondary"
for i in {1..5}; do
	sway workspace $i output "$primary"
done
for i in {6..10}; do
	sway workspace $i output "$secondary"
done

# Bar
bash "/home/$USER/.config/yambar/scripts/launch-yambar.sh"

# Completed Notification
notify-send "System" "Configured to work setup" \
	-h string:x-canonical-private-synchronous:display-config &
