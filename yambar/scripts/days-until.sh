#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 YYYY-MM-DD"
	exit 1
fi

input_date=$1
current_seconds=$(date +%s)
input_seconds=$(date -d "$input_date" +%s)

diff_seconds=$((current_seconds - input_seconds))
remainder_seconds=$((diff_seconds % 86400))

days_until=$((diff_seconds / 86400))
hours_until=$((remainder_seconds / 3600))

# notify-send -u critical "Smart person" "Remember, just $days_until days until finals..."

if [ days_until -gt 0 ]; then
	echo "days|string|+$days_until"
else
	echo "days|string|$days_until"
fi

if [ hours_until -gt 0 ]; then
	echo "hours|string|+$hours_until"
else
	echo "hours|string|$hours_until"
fi

echo ""
