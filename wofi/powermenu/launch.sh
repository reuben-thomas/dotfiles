#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

declare -g original_volume

mute_nest() {
  original_volume=$(pactl get-sink-volume bluez_output.CC_F4_11_DA_58_B3.1 | awk '{print $NF}' | tr -d '%')
  pactl set-sink-mute bluez_output.CC_F4_11_DA_58_B3.1 1
  pactl set-sink-volume bluez_output.CC_F4_11_DA_58_B3.1 0
}

unmute_nest() {
  pactl set-sink-mute bluez_output.CC_F4_11_DA_58_B3.1 0
  if [[ -n "$original_volume" ]]; then
    pactl set-sink-volume bluez_output.CC_F4_11_DA_58_B3.1 "$original_volume%"
    unset original_volume
  fi
}

op=$(echo -e " PowerStats\n Sync\n Lock\n⭘ Suspend\n Windows\n UEFI\n󰜉 Reload\n Restart\n󰐥 Poweroff" |
  wofi -i --dmenu \
    -c $SCRIPT_DIR/../config \
    -s $SCRIPT_DIR/style.css |
  awk '{print tolower($2)}')

fatal() {
  echo "FATAL ERROR: $@"
  notify-send "System" "$@" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  exit 1
}

case $op in
poweroff)
  notify-send "System" "Shutting Down" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  for i in $(seq 1 $END); do echo $i; done
  # display_count=$(ddcutil detect | grep -c '^Display [0-9]*')
  # for ((display = 1; display <= $display_count; display++)); do
  #   ddcutil setvcp D6 05 --display "$display" --noverify --async
  # done
  systemctl poweroff
  ;&
restart)
  mute_nest
  notify-send "System" "Restarting" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  systemctl reboot
  ;&
windows)
  notify-send "System" "Restarting into  Windows 11" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  trap 'sudo -k' EXIT
  zenity --password |
    sudo -Sv || fatal "Authentication Failed"
  mute_nest
  sudo grub-reboot 2
  systemctl reboot
  ;;
uefi)
  mute_nest
  notify-send "System" "Entering UEFI Setup" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  trap 'sudo -k' EXIT
  zenity --password |
    sudo -Sv || fatal "Authentication Failed"
  sudo grub-reboot 3
  systemctl reboot
  ;;
reload)
  notify-send "System" "Reloading Sway" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  swaymsg reload
  ;;
suspend)
  mute_nest
  notify-send "System" "Exiting Sway" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  swaymsg exit
  ;;
lock)
  notify-send "System" "Swaylock" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  $HOME/.config/scripts/lock.sh
  ;;
sync)
  /home/reuben/.config/scripts/sync.sh
  ;;
powerstats)
  flatpak run org.gnome.PowerStats
  ;;
esac

if [[ -n "$original_volume"]]; then
  unmute_nest
fi


