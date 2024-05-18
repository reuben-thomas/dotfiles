#!/bin/bash

display_count=$(ddcutil detect | grep -c '^Display [0-9]*')
BRIGHTNESS=$1

for ((display = 1; display <= $display_count; display++)); do
	ddcutil setvcp 10 "$BRIGHTNESS" --display "$display" --noverify --async

done
