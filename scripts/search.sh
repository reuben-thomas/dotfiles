#!/bin/sh

quote_search_terms() {
  for term in "$@"; do
    echo -n "$term "
  done
}

if [ "${1#?}" != "$1" ] && [ "${1%"${1#?}"}" = "!" ]; then
  xdg-open "https://search.brave.com/search?q=$(quote_search_terms "$@")"
else
  xdg-open "https://www.google.com/search?q=$(quote_search_terms "$@")"
fi
