makoctl reload

notify_and_dismiss() {
  local id
  id=$(notify-send --print-id "$@")
  (
    sleep 5
    makoctl dismiss -n "$id"
  ) &
}

notify_and_dismiss -u critical "Critical" "This is what a critical message looks like."
notify_and_dismiss "Standard" "This is what a standard message looks like."
notify_and_dismiss -a Spotify "Spotify" "This is what notifications from spotify looks like."
notify_and_dismiss "Denise ❤️" "This is what notifications from Denise look like"
