#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

op=$(echo -e " PowerStats\n Sync\n Lock\n⭘ Suspend\n UEFI\n󰜉 Reload\n Restart\n󰐥 Shutdown\n󰶐 Poweroff" |
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
  notify-send "System" "Powering Off" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  for i in $(seq 1 $END); do echo $i; done
  display_count=$(ddcutil detect | grep -c '^Display [0-9]*')
  for ((display = 1; display <= $display_count; display++)); do
    ddcutil setvcp D6 05 --display "$display" --noverify --async
  done
  systemctl poweroff
  ;&
shutdown)
  notify-send "System" "Shutting Down" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  for i in $(seq 1 $END); do echo $i; done
  systemctl poweroff
  ;&
restart)
  notify-send "System" "Restarting" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  systemctl reboot
  ;&
windows)
  notify-send "System" "Restarting into  Windows 11" \
    -h string:x-canonical-private-synchronous:powermenu-notif &
  # pkexec sh -c "grub-reboot 1"
  pkexec sh -c "echo 'im the menu' >> /home/reuben/Downloads/hi.txt"
  # systemctl reboot
  ;&
uefi)
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
