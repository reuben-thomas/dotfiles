killall yambar

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m yambar &
	done
else
	notify-send "Hello"
fi
