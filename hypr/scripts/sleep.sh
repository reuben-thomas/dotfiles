#!/bin/bash
if systemctl --user is-active --quiet lid-inhibit; then
    echo "Sleep: Disabled"
else
    echo "Sleep: Enabled"
fi
