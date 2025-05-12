#!/bin/bash

SAVEDIR=~/Pictures/Screenshots
mkdir -p -- "$SAVEDIR"
FILENAME="$SAVEDIR/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"
EXPANDED_FILENAME="${FILENAME/#\~/$HOME}"

grim -g "$(slurp)" "$EXPANDED_FILENAME"
# Swappy for editing and annotations
# swappy -f "$EXPANDED_FILENAME" -o "$EXPANDED_FILENAME"

wl-copy <"$EXPANDED_FILENAME"
notify-send "Screenshot" "File saved as <i>'$FILENAME'</i> and copied to the clipboard." -i "$EXPANDED_FILENAME"
