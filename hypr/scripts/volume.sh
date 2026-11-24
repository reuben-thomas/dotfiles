#!/bin/bash
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -1)
if pactl get-sink-mute @DEFAULT_SINK@ | grep -q 'yes'; then
    echo "Volume: ${volume:-?} (muted)"
else
    echo "Volume: ${volume:-?}"
fi
