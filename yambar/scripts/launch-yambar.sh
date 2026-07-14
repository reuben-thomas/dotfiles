#!/bin/bash

killall yambar
outputs=$(swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name + "," + (.rect.width | tostring) + "," + (.scale | tostring)')

config="$HOME/.config/yambar/config.yml"
tmpdir="$(dirname "$config")/.tmp"
rm -rf "$tmpdir"
mkdir -p "$tmpdir"

while IFS=, read -r name width scale; do
  echo $name
  echo $scale

  if [[ "$name" == "HEADLESS-1" ]]; then
    continue
  else
    tmpconfig="$tmpdir/config-$name.yml"
    sed "s/^  monitor:.*/  monitor: $name/" "$config" >"$tmpconfig"
    yambar -c "$tmpconfig" &
  fi

done <<<"$outputs"
