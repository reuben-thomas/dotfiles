#!/bin/bash

if pgrep -x wf-recorder >/dev/null; then
  killall wf-recorder
  exit 0
fi

SAVE_GIF=false
while [[ $# -gt 0 ]]; do
  case $1 in
  --save-gif)
    SAVE_GIF=true
    shift
    ;;
  *)
    echo "Unknown option: $1"
    echo "Usage: $0 [--save-gif]"
    exit 1
    ;;
  esac
done

SAVEDIR=~/Videos/Screencasts
mkdir -p -- "$SAVEDIR"
TIMESTAMP=$(date +'%Y-%m-%d-%H%M%S')
MP4_FILENAME="$SAVEDIR/${TIMESTAMP}_screencast.mp4"
EXPANDED_MP4="${MP4_FILENAME/#\~/$HOME}"

wf-recorder -g "$(slurp)" -f "$MP4_FILENAME"

if [ "$SAVE_GIF" = true ]; then
  GIF_FILENAME="$SAVEDIR/${TIMESTAMP}_screencast.gif"
  EXPANDED_GIF="${GIF_FILENAME/#\~/$HOME}"

  notify-send "Screencast" "Recording saved as <i>$MP4_FILENAME</i>. Converting to <i>$EXPANDED_GIF</i>" -i "$EXPANDED_MP4"
  ffmpeg -i "$EXPANDED_MP4" -filter_complex "[0:v] fps=15,scale=iw/2:-1:flags=lanczos,split [a][b];[a] palettegen [p];[b][p] paletteuse" "$EXPANDED_GIF"
  wl-copy <"$EXPANDED_GIF"
  notify-send "Screencast" "Recording saved as <i>$GIF_FILENAME</i> and copied to clipboard." -i "$EXPANDED_GIF"
else
  wl-copy <"$EXPANDED_MP4"
  notify-send "Screencast" "Recording saved as <i>$EXPANDED_MP4</i> and copied to clipboard." -i "$EXPANDED_MP4"
fi
