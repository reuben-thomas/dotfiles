#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

query=$(wofi -i --dmenu \
  -c "$SCRIPT_DIR/config" \
  -s "$SCRIPT_DIR/style.css" \
  -p "Search:")

~/.config/scripts/search.py "$query"
