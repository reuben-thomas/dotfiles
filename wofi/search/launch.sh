#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

query=$(wofi -i --dmenu \
  -c "$SCRIPT_DIR/config" \
  -s "$SCRIPT_DIR/style.css" \
  -p "Search:")

quote_search_terms() {
  echo -n "$1" | sed 's/ /+/g'
}

if [ -n "$query" ]; then
  if [[ "$query" == "!"* ]]; then
    search_url="https://search.brave.com/search?q=$(quote_search_terms "$query")"
  else
    search_url="https://www.google.com/search?q=$(quote_search_terms "$query")"
  fi

  xdg-open "$search_url"
fi
