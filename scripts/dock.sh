#!/bin/bash

# Layout Without Scale
sway output "'Dell Inc. DELL S3422DWG 48LXSH3'" pos 0 480 scale 1
sway output "'Goldstar Company Ltd LG FULL HD '" pos 3440 230 scale 1 transform 90
sway output eDP-1 disable

# sway output DP-5 enable pos 0 480
# sway output DP-7 enable pos 3440 230 transform 90
# sway output eDP-1 disable

# Layout With Scale
# sway output eDP-1 disable
# sway output "'Dell Inc. DELL S3422DWG 48LXSH3'" pos 0 530
# sway output "'Goldstar Company Ltd LG FULL HD '" pos 3440 0 scale 0.85 transform 90

# Assign Workspaces
sway workspace music output "'Goldstar Company Ltd LG FULL HD '"
for i in {1..5}; do
	sway workspace $i output "'Dell Inc. DELL S3422DWG 48LXSH3'"
done
for i in {6..10}; do
	sway workspace $i output "'Goldstar Company Ltd LG FULL HD '"
done

# Bar
bash "/home/$USER/.config/yambar/scripts/launch-yambar.sh"

# Completed Notification
notify-send "System" "Configured to home setup" \
	-h string:x-canonical-private-synchronous:display-config &
