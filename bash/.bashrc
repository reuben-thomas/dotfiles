# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# if command -v theme.sh >/dev/null; then
# 	[ -e ~/.theme_history ] && theme.sh "$(theme.sh -l | tail -n1)"
# 	bind -x '"\C-o":"theme.sh $(theme.sh -l|tail -n2|head -n1)"'
# 	alias th='theme.sh -i'
# 	alias thl='theme.sh --light -i'
# 	alias thd='theme.sh --dark -i'
# fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

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

# App Shortcuts
alias code='code --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --ozone-platform-hint=auto > /dev/null 2>&1'
alias sync='/home/reuben/.config/scripts/sync.sh'
alias socvpn='sudo openfortivpn webvpn.comp.nus.edu.sg --username=e1123003 --password=$(python3 -c "import keyring; print(keyring.get_password(\"soc\", \"e1123003\"))")'
alias xlog='ssh reubenth@xlog.comp.nus.edu.sg'
alias chrome='google-chrome --password-store=gnome-libsecret'
alias typetest='tt -showwpm -notheme -blockcursor'
alias battop='/home/reuben/utils/battop-v0.2.4-x86_64-unknown-linux-gnu'
alias powerstats='flatpak run org.gnome.PowerStats&exit'
alias logisim='/home/reuben/cs/CS2100/logisim/launch.sh'
alias usql2102='usql postgres://postgres@localhost/postgres'

# Pure Laziness
alias noise='play -n synth brownnoise'
alias rec='/home/reuben/.config/scripts/screencast.sh; cd /home/reuben/Videos/Screencasts/'
alias work='/home/reuben/.config/scripts/work.sh'
alias dock='/home/reuben/.config/scripts/dock.sh'
alias yam='/home/reuben/.config/yambar/scripts/launch-yambar.sh'
alias zoxadd='/home/reuben/.config/scripts/zoxide-add.sh'
alias r='ranger'
alias p='wl-paste >'
alias e='exit'
alias t='tmux'

# Obsidian Notes
alias obs='cd ~/Documents/Obsidian; nvim .'
alias note='cd ~/Documents/Note; nvim .'

# Dev Shortcuts
dev-service() {
  local action=$1
  shift
  for service in docker docker.socket apache2 postgresql forticlient; do
    sudo systemctl "$action" "$service"
  done
}
alias dev-start='dev-service start'
alias dev-stop='dev-service stop'
alias dev-enable='dev-service enable'
alias dev-disable='dev-service disable'
alias activate='source ~/.venv/base/bin/activate'
alias vcpkg='function _vcpkg_alias(){ /home/reuben/utils/vcpkg/vcpkg "$@"; }; _vcpkg_alias'

# System Shortcuts
alias powerstatus='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias pcipm-enable='echo auto | sudo tee /sys/bus/pci/devices/*/power/control'
alias buds='flatpak run me.timschneeberger.GalaxyBudsClient action -e Connect'
alias lume-all='python3 /home/reuben/.config/scripts/lume.py $1'
alias lume='ddcutil setvcp 10'
alias gaps='f() { swaymsg gaps inner all set "$1"; swaymsg gaps inner "$1"; }; f'
alias boot-windows='sudo grub-reboot 2; systemctl reboot'
alias boot-uefi='sudo grub-reboot 3; systemctl reboot'
alias autosuspend-off='sudo /home/reuben/.config/scripts/autosuspend-off.sh'
alias autosuspend-status='cat /sys/module/usbcore/parameters/autosuspend'

# Created by `pipx` on 2023-12-13 10:18:49
export PATH="$PATH:/home/reuben/.local/bin"
. "$HOME/.cargo/env"

export PATH="$PATH:/home/reuben/.config/scripts"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# zoxide
eval "$(zoxide init bash)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# java
export PATH_TO_FX="$HOME/.local/share/javafx-sdk-17.0.13/lib"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

# go
alias go="go1.24.1"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/reuben/go/bin

# vcpkg
source /home/reuben/utils/vcpkg/scripts/vcpkg_completion.bash

# esp-idf
alias idf-activate='. $HOME/utils/esp/esp-idf/export.sh'

# wayvnc
export PATH="$HOME/utils/vnc/wayvnc/build:$PATH"
alias ipad-connect='/home/reuben/.config/wayvnc/ipad-launch.sh'

# dell command-configure
export PATH="/opt/dell/dcc:$PATH"
alias cctk='sudo env PATH=$PATH cctk'
alias charge-express='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Express'
alias charge-dock='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Custom:50-60'
alias charge-std='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Standard'
alias thermal-performance='sudo env PATH=$PATH cctk --ThermalManagement=UltraPerformance'
alias thermal-optimized='sudo env PATH=$PATH cctk --ThermalManagement=Optimized'
alias thermal-cool='sudo env PATH=$PATH cctk --ThermalManagement=Cool'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# conda
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/reuben/.anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
# if [ $? -eq 0 ]; then
#   eval "$__conda_setup"
# else
#   if [ -f "/home/reuben/.anaconda3/etc/profile.d/conda.sh" ]; then
#     . "/home/reuben/.anaconda3/etc/profile.d/conda.sh"
#   else
#     export PATH="/home/reuben/.anaconda3/bin:$PATH"
#   fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# gradle
export GRADLE_HOME="$HOME/.gradle/wrapper/dists/gradle-8.12.1-bin/eumc4uhoysa37zql93vfjkxy0/gradle-8.12.1"
export PATH="$GRADLE_HOME/bin:$PATH"
alias gradle="$GRADLE_HOME/bin/gradle"

# vim mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
export EDITOR=nvim

# search
alias s="~/.config/scripts/search.py"

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# terraform
complete -C /usr/bin/terraform terraform
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
