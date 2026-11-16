# ble.sh
[[ $- == *i* ]] && source -- ~/.local/share/blesh/ble.sh --noattach

# If not running interactively, no action
case $- in
*i*) ;;
*) return ;;
esac

#==========================================================
# history
#==========================================================

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#==========================================================
# sizing
#==========================================================

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#==========================================================
# completion
#==========================================================

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#==========================================================
# utils
#==========================================================

# vim mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
export EDITOR=nvim

# convenience scripts
export PATH="$PATH:$HOME/.config/scripts"

bak() {
  for f in "$@"; do
    cp -a -- "$f" "$f.bak.$(date +%Y%m%d-%H%M%S)"
  done
}

time-sync() {
  local tz
  tz=$(curl -sf --max-time 10 https://ifconfig.co/json | jq -r '.time_zone // empty')
  if [[ -n $tz ]]; then
    sudo timedatectl set-timezone "$tz" && echo "Time zone: $tz"
    sudo systemctl restart systemd-timesyncd
  else
    echo "Time zone lookup failed; keeping $(timedatectl show -p Timezone --value)" >&2
  fi
}

#==========================================================
# laziness
#==========================================================

# colors
alias diff='diff --color=auto -u'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# apps
alias nusvpn='openconnect-lite --server 8d0c.vpn.sse.cisco.com/NUSStudent'
alias obs='cd ~/Documents/Obsidian; nvim .'

alias p='wl-paste >'
alias e='exit'

t() {
  if [ $# -eq 0 ]; then
    tmux attach || tmux
  else
    tmux new-session -s "$1"
  fi
}

#==========================================================
# dev services
#==========================================================

dev-service() {
  local action=$1
  shift
  for service in docker docker.socket; do
    sudo systemctl "$action" "$service"
  done
}

alias dev-start='dev-service start'
alias dev-stop='dev-service stop'
alias dev-enable='dev-service enable'
alias dev-disable='dev-service disable'
alias activate='source ~/.venv/base/bin/activate'

#==========================================================
# system
#==========================================================

alias powerstatus='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias pcipm-enable='echo auto | sudo tee /sys/bus/pci/devices/*/power/control'
alias lume='ddcutil setvcp 10'
alias boot-windows='sudo grub-reboot 2 && systemctl reboot'
alias boot-uefi='sudo grub-reboot 3 && systemctl reboot'
alias autosuspend-off='sudo $HOME/.config/scripts/autosuspend-off.sh'
alias autosuspend-status='cat /sys/module/usbcore/parameters/autosuspend'

# dell command-configure
export PATH="/opt/dell/dcc:$PATH"
alias cctk='sudo env PATH=$PATH cctk'
alias charge-express='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Express'
alias charge-dock='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Custom:50-60'
alias charge-std='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Standard'
alias thermal-performance='sudo env PATH=$PATH cctk --ThermalManagement=UltraPerformance'
alias thermal-optimized='sudo env PATH=$PATH cctk --ThermalManagement=Optimized'
alias thermal-cool='sudo env PATH=$PATH cctk --ThermalManagement=Cool'

gaps() {
  swaymsg gaps inner all set "$1"
}

#==========================================================
# languages and tooling
#==========================================================

# bin
export PATH="$PATH:$HOME/.local/bin"

# perf
alias allow-perf='sudo sysctl -w kernel.perf_event_paranoid=-1'

# gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# rust
. "$HOME/.cargo/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

_confset() {
  local varname="$1" dir="$2" name="$3"

  if [[ -z "$name" ]]; then
    echo "usage: ${FUNCNAME[1]} <config-name>" >&2
    return 1
  fi

  local path="$dir/$name"

  if [[ ! -f "$path" ]]; then
    echo "${FUNCNAME[1]}: $path not found" >&2
    return 1
  fi

  export "$varname=$path"
  echo "$varname set to $path"
}

# talos
talosconf() { _confset TALOSCONFIG "$HOME/.talos" "$1"; }

# kubernetes
kubeconf() { _confset KUBECONFIG "$HOME/.kube" "$1"; }

# terraform
complete -C /usr/bin/terraform terraform
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

# java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# go
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$(go env GOPATH)/bin"

# ocaml
eval "$(opam env --switch=default)"

# nvidia nsight
export PATH="/usr/local/NVIDIA-Nsight-Compute:$PATH"

# tectonic
tex-comp() {
  tectonic \
    --keep-logs \
    --synctex \
    -Z shell-escape \
    -Z continue-on-errors \
    --bundle https://data1.fullyjustified.net/tlextras-2022.0r0.tar \
    "$1"
}

#==========================================================
# claude
#==========================================================

ask() {
  claude -p \
    --model claude-haiku-5-5 \
    --tools "" \
    --disallowedTools "*" \
    --strict-mcp-config \
    --safe-mode \
    --permission-prompts none \
    --no-session-persistence \
    "$*"
}

claude-desktop-open() {
  local enc
  enc=$(python3 -c 'import sys,urllib.parse;print(urllib.parse.quote(sys.argv[1],safe=""))' "$PWD")
  setsid -f xdg-open "claude://code/new?folder=${enc}" >/dev/null 2>&1
}

#==========================================================
# shell
#==========================================================

# starship
eval "$(starship init bash)"

# zoxide
eval "$(zoxide init bash)"
alias zadd='zoxide-add.sh'

# fzf
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/fzfrc"
export FZF_CTRL_T_OPTS="
  --preview 'batcat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# ble.sh
if [[ ${BLE_VERSION-} ]]; then
  ble-import -d integration/fzf-key-bindings
  ble-import -d integration/fzf-completion
  ble-attach
fi
