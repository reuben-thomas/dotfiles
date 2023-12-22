#!/bin/bash

# Function to send a follow-up notification
send_followup_notification() {
	notify-send "Follow-up Notification" "This is a response to your action."
}

# Export the function for dbus-monitor
export -f send_followup_notification

# Send the initial notification with an action, with a 5-second timeout
gdbus call \
	--session \
	--dest org.freedesktop.Notifications \
	--object-path /org/freedesktop/Notifications \
	--method org.freedesktop.Notifications.Notify \
	"identifier" \
	"0" \
	"" \
	"Notification title" \
	"Notification description" \
	"['action_key', 'Click Me']" \
	"{}" \
	"5000" &

# Set a PID for the gdbus call
GDBUS_PID=$!

# Timeout for listening to dbus-monitor
{
	sleep 5
} &

# Listen for the action being invoked
dbus-monitor "interface='org.freedesktop.Notifications',member='ActionInvoked'" |
	while read x; do
		if [[ "$x" == *"string \"action_key\""* ]]; then
			send_followup_notification
		fi
	done
