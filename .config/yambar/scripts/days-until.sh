#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 YYYY-MM-DD"
	exit 1
fi

input_date=$1
current_seconds=$(date +%s)
input_seconds=$(date -d "$input_date" +%s)

diff_seconds=$((input_seconds - current_seconds))
remainder_seconds=$((diff_seconds % 86400))

days_until=$((diff_seconds / 86400))
hours_until=$((remainder_seconds / 3600))

# notify-send -u critical "Smart person" "Remember, just $days_until days until finals..."

echo "days|string|$days_until"
echo "hours|string|$hours_until"
echo ""
