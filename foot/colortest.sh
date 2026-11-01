#!/bin/bash

names=(black red green yellow blue magenta cyan white)

query() {
  local reply
  printf '\e]4;%d;?\e\\' "$1" >/dev/tty
  IFS= read -rs -d '\' -t 1 reply </dev/tty
  reply=${reply#*rgb:}
  reply=${reply%%[^0-9a-fA-F/]*}
  IFS=/ read -r r g b <<<"$reply"
  printf '%s%s%s' "${r:0:2}" "${g:0:2}" "${b:0:2}"
}

saved=$(stty -g </dev/tty)
trap 'stty "$saved" </dev/tty' EXIT
stty -icanon -echo </dev/tty

for i in {0..15}; do
  name=${names[i % 8]}
  ((i >= 8)) && name="bright $name"
  hex=$(query "$i")
  printf '%-16s \e[48;5;%dm      \e[0m %s\n' "$name" "$i" "$hex"
done
