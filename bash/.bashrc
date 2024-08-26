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
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  #alias grep='grep --color=auto'
  #alias fgrep='fgrep --color=auto'
  #alias egrep='egrep --color=auto'
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

change_scheme() {
  if [ "$scheme" = "night" ]; then
    /usr/bin/theme.sh dracula
  else
    /usr/bin/theme.sh belafonte-day
  fi
}
trap 'change_scheme' USR1

# App Shortcuts
alias code='code --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --ozone-platform-hint=auto > /dev/null 2>&1'
alias obsidian-sync='/home/reuben/.config/scripts/obsidian-sync.sh'
alias socvpn-start='sudo openfortivpn webvpn.comp.nus.edu.sg --username=e1123003'
alias chrome='google-chrome --password-store=gnome-libsecret'
alias typetest='tt -showwpm -notheme -blockcursor'
alias battop='/home/reuben/utils/battop-v0.2.4-x86_64-unknown-linux-gnu'
alias powerstats='flatpak run org.gnome.PowerStats&exit'
alias logisim='/home/reuben/cs/CS2100/logisim/launch.sh'

# Pure Laziness
alias work='/home/reuben/.config/scripts/work.sh'
alias dock='/home/reuben/.config/scripts/dock.sh'
alias yam='/home/reuben/.config/yambar/scripts/launch-yambar.sh'
alias zoxadd='/home/reuben/.config/scripts/zoxide-add.sh'
alias rg='ranger'
alias e='exit'
alias t='tmux'

# Obsidian Notes
alias obs='cd ~/Documents/Obsidian; nvim .'
alias note='cd ~/Documents/Note; nvim Note.md'
alias todo='cd ~/Documents/Obsidian; nvim TODO.md'
# For opening with non-system theme
# alias obs='nvim ~/Documents/Obsidian -c "colorscheme tokyonight"'
# alias note='nvim ~/Documents/Notes -c "colorscheme tokyonight"'

# Dev Shortcuts
alias dev-start='sudo systemctl enable docker && sudo systemctl enable postgresql'
alias dev-stop='sudo systemctl disable docker && sudo systemctl disable postgresql'
alias activate='source ~/.venv/base/bin/activate'
alias vcpkg='function _vcpkg_alias(){ /home/reuben/utils/vcpkg/vcpkg "$@"; }; _vcpkg_alias'

# System Shortcuts
alias powerstatus='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias pcipm-enable='echo auto | sudo tee /sys/bus/pci/devices/*/power/control'
alias buds='sudo service bluetooth restart; bluetoothctl connect DC:69:E2:BA:90:08'
alias nest='sudo service bluetooth restart; bluetoothctl connect CC:F4:11:DA:58:B3'
alias lume='python3 /home/reuben/.config/scripts/lume.py $1'
alias boot-windows='sudo grub-reboot 2; systemctl reboot'
alias boot-uefi='sudo grub-reboot 3; systemctl reboot'

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

# vcpkg
source /home/reuben/utils/vcpkg/scripts/vcpkg_completion.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# conda
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/reuben/.anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/home/reuben/.anaconda3/etc/profile.d/conda.sh" ]; then
    . "/home/reuben/.anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/home/reuben/.anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<
