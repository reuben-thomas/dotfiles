#!/bin/bash
# Usage: capture.sh pick <shot|video|gif>
#        capture.sh <shot|video|gif> <region|window|output|all>
#        capture.sh stop

stamp=$(date +'%Y-%m-%d-%H%M%S')

is_recording() {
  pgrep -x wf-recorder >/dev/null
}

stop_recording() {
  pkill -INT -x wf-recorder
}

close_selection() {
  pkill -x slurp || return 0
  while pgrep -x slurp >/dev/null; do sleep 0.05; done
}

visible_windows() {
  swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'
}

focused_output() {
  swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name'
}

select_geometry() {
  case $1 in
  region) slurp ;;
  window) visible_windows | slurp -r ;;
  output) slurp -o ;;
  all) ;;
  esac
}

take_screenshot() {
  local geometry=$1
  local dir=~/Pictures/Screenshots
  local file="$dir/${stamp}_screenshot.png"
  mkdir -p "$dir"

  if [ -n "$geometry" ]; then
    grim -g "$geometry" "$file"
  else
    grim "$file"
  fi

  wl-copy <"$file"
  notify-send "Screenshot" "Saved as <i>$file</i> and copied to the clipboard." -i "$file"
}

record() {
  local geometry=$1 file=$2

  if [ -n "$geometry" ]; then
    wf-recorder -g "$geometry" -f "$file"
  else
    wf-recorder -o "$(focused_output)" -f "$file"
  fi
}

convert_to_gif() {
  local mp4=$1 gif=$2
  notify-send "Screencast" "Converting to <i>$gif</i>..." -i "$mp4"
  ffmpeg -i "$mp4" -filter_complex "[0:v] fps=15,scale=iw/2:-1:flags=lanczos,split [a][b];[a] palettegen [p];[b][p] paletteuse" "$gif"
}

take_screencast() {
  local kind=$1 geometry=$2
  local dir=~/Videos/Screencasts
  local file="$dir/${stamp}_screencast.mp4"
  mkdir -p "$dir"

  record "$geometry" "$file"

  if [ "$kind" = gif ]; then
    convert_to_gif "$file" "$dir/${stamp}_screencast.gif"
    file="$dir/${stamp}_screencast.gif"
  fi

  wl-copy --type text/uri-list "file://$file"
  notify-send "Screencast" "Saved as <i>$file</i> and copied to the clipboard." -i "$file"
}

capture() {
  local kind=$1 geometry=$2

  if [ "$kind" = shot ]; then
    take_screenshot "$geometry"
    return
  fi

  take_screencast "$kind" "$geometry"
}

if [ "$1" = stop ]; then
  stop_recording
  exit 0
fi

if [ "$1" = pick ]; then
  kind=$2

  if [ "$kind" != shot ] && is_recording; then
    stop_recording
    exit 0
  fi

  swaymsg -q mode "capture-$kind"
  geometry=$(select_geometry region)
  status=$?
  swaymsg -q mode default

  [ $status -eq 0 ] || exit 0

  capture "$kind" "$geometry"
  exit 0
fi

kind=$1
target=$2

case $target in
region | window | output | all) ;;
*)
  echo "Unknown target: $target" >&2
  exit 1
  ;;
esac

close_selection
geometry=$(select_geometry "$target") || exit 0
capture "$kind" "$geometry"
