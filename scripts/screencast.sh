#!/bin/bash

SAVEDIR=~/Videos/Screencasts
mkdir -p -- "$SAVEDIR"

TIMESTAMP=$(date +'%Y-%m-%d-%H%M%S')
FILENAME="$SAVEDIR/${TIMESTAMP}_screencast.mp4"
GIF_FILENAME="$SAVEDIR/${TIMESTAMP}_screencast.gif"

EXPANDED_FILENAME="${FILENAME/#\~/$HOME}"
EXPANDED_GIF="${GIF_FILENAME/#\~/$HOME}"

wf-recorder -g "$(slurp)" -f "$EXPANDED_FILENAME"
ffmpeg -i "$EXPANDED_FILENAME" -filter_complex "[0:v] fps=15,scale=iw/2:-1:flags=lanczos,split [a][b];[a] palettegen [p];[b][p] paletteuse" "$EXPANDED_GIF"

wl-copy <"$EXPANDED_FILENAME"

notify-send "Screencast" "Recording saved as <i>$GIF_FILENAME</i> and copied to clipboard." -i "$EXPANDED_GIF"
