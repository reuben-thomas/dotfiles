#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/wofi-brightness"
mkdir -p "$CACHE_DIR"

SKIP_CODES=(02 52 AC AE B2 B6 C6 C8 C9 DF)
BASE_CODES=(10 D6)
ACTION_CODES=(04 05 08)

menu() {
  wofi -i --dmenu \
    -c "$SCRIPT_DIR/../config" \
    -s "$SCRIPT_DIR/style.css" \
    -p "$1"
}

notify() {
  notify-send "Brightness" "$@" \
    -h string:x-canonical-private-synchronous:brightness-notif &
}

ask_value() {
  local max=$2 sel
  sel=$(printf '%s\n' 100 75 50 25 10 0 +10 -10 | menu "$1") || return 1
  sel=${sel//[% ]/}
  [[ $sel =~ ^[+-]?[0-9]+$ ]] || { notify "Invalid value: $sel"; return 1; }
  echo "$sel"
}

builtin_get() { brightnessctl -m -c backlight | head -1 | cut -d, -f4; }

builtin_set() {
  local v=$1
  case $v in
  +*) brightnessctl -q -c backlight set "${v#+}%+" ;;
  -*) brightnessctl -q -c backlight set "${v#-}%-" ;;
  *) brightnessctl -q -c backlight set "$v%" ;;
  esac
}

list_displays() {
  ddcutil detect --brief 2>/dev/null | awk '
    /^Display [0-9]+/ { valid=1; bus=""; next }
    /^Invalid display/ { valid=0; next }
    valid && /I2C bus:/ { sub(/.*i2c-/, ""); bus=$0 }
    valid && /Monitor:/ { sub(/.*Monitor: */, ""); n=split($0, a, ":"); print bus "\t" a[2] " (" a[n] ")"; valid=0 }'
}

ddc() { ddcutil --bus "$BUS" --noverify "$@" 2>/dev/null; }

capabilities() {
  local f="$CACHE_DIR/$(echo "$MODEL" | tr -c 'A-Za-z0-9\n' '_')"
  [[ -s $f ]] || ddc capabilities >"$f"
  cat "$f"
}

in_list() {
  local needle=$1 item
  shift
  for item in "$@"; do
    [[ $item == "$needle" ]] && return 0
  done
  return 1
}

all_features() {
  capabilities |
    sed -n 's/^   Feature: \([0-9A-F]\{2\}\) (\(.*\))$/\1\t\2/p' |
    grep -v 'Manufacturer specific'
}

features() {
  local all code name
  all=$(all_features)

  for code in "${BASE_CODES[@]}"; do
    grep "^$code"$'\t' <<<"$all"
  done

  while IFS=$'\t' read -r code name; do
    in_list "$code" "${BASE_CODES[@]}" "${ACTION_CODES[@]}" "${SKIP_CODES[@]}" && continue
    printf '%s\t%s\n' "$code" "$name"
  done <<<"$all"

  for code in "${ACTION_CODES[@]}"; do
    grep "^$code"$'\t' <<<"$all"
  done
}

feature_values() {
  capabilities | awk -v code="$1" '
    $0 ~ "^   Feature: " code " " { inf=1; next }
    inf && /^   Feature:/ { exit }
    inf && /^         [0-9a-fA-F]{2}: / { sub(/^ +/, ""); print }'
}

ddc_set_percent() {
  local v=$2
  case $v in
  +*) ddcutil --bus "$1" --noverify setvcp 10 + "${v#+}" ;;
  -*) ddcutil --bus "$1" --noverify setvcp 10 - "${v#-}" ;;
  *) ddcutil --bus "$1" --noverify setvcp 10 "$v" ;;
  esac 2>/dev/null
}

choice_feature_menu() {
  local code=$1 name=$2 values=$3 cur=$4 cur_label sel
  cur_label=$(grep -i "^$cur:" <<<"$values" | cut -d' ' -f2-)

  sel=$(menu "$name [${cur_label:-$cur}]" <<<"$values") || return
  ddc setvcp "$code" "0x${sel%%:*}" &&
    notify "$MODEL: $name → ${sel#*: }"
}

range_feature_menu() {
  local code=$1 name=$2 cur=$3 max=$4 v
  v=$(ask_value "$name [$cur/$max]" "$max") || return

  case $v in
  +* | -*) ddc setvcp "$code" "${v:0:1}" "${v:1}" ;;
  *) ddc setvcp "$code" "$v" ;;
  esac && notify "$MODEL: $name → $v"
}

action_feature_menu() {
  local code=$1 name=$2 sel
  sel=$(printf 'No\nYes\n' | menu "$name?") || return

  [[ $sel == Yes ]] &&
    ddc setvcp "$code" 1 &&
    notify "$MODEL: $name"
}

feature_menu() {
  local code=$1 name=$2 values type cur max
  values=$(feature_values "$code")
  read -r _ _ type cur max < <(ddc getvcp "$code" --brief)

  if [[ -n $values ]]; then
    choice_feature_menu "$code" "$name" "$values" "${cur#x}"
  elif [[ $type == C ]]; then
    range_feature_menu "$code" "$name" "$cur" "$max"
  else
    action_feature_menu "$code" "$name"
  fi
}

display_menu() {
  local feats sel code
  feats=$(features)
  sel=$(echo "$feats" | awk -F'\t' '{print $1 "  " $2}' | menu "$MODEL") || return
  code=${sel%% *}
  feature_menu "$code" "$(echo "$feats" | awk -F'\t' -v c="$code" '$1==c {print $2}')"
}

mapfile -t DISPLAYS < <(list_displays)

entries="󰖨 Global Brightness\n󰃠 Builtin Brightness [$(builtin_get)]"
for i in "${!DISPLAYS[@]}"; do
  entries+="\n󰍹 Display $((i + 1)): ${DISPLAYS[i]#*$'\t'}"
done

op=$(echo -e "$entries" | menu "Brightness") || exit 0

case $op in
*Builtin*)
  v=$(ask_value "Builtin Brightness [$(builtin_get)]" 100) || exit 0
  builtin_set "$v" && notify "Builtin Brightness → $(builtin_get)"
  ;;
*Global*)
  v=$(ask_value "Global Brightness" 100) || exit 0
  builtin_set "$v" &
  for d in "${DISPLAYS[@]}"; do ddc_set_percent "${d%%$'\t'*}" "$v" & done
  wait
  notify "Global Brightness → $v"
  ;;
*Display*)
  n=$(echo "$op" | sed 's/.*Display \([0-9]*\):.*/\1/')
  d=${DISPLAYS[n - 1]}
  BUS=${d%%$'\t'*} MODEL=${d#*$'\t'}
  display_menu
  ;;
esac
