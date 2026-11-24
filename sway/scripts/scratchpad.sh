#!/bin/sh

claude_ext=fmpnliohjhemenmnlpbfagaolkdacoja

swaymsg \
    "[app_id=scratchpadTerm] kill;" \
    "[app_id=brave-$claude_ext-Default] kill"

foot \
    --app-id scratchpadTerm \
    -e bash -ic yazi &

brave-browser \
    --app-id="$claude_ext" &
