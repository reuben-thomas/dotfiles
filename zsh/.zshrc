ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

zstyle ':omz:update' mode reminder

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

plugins=(
  git
  ssh-agent
  zsh-vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# default app overrides
alias code='code --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --ozone-platform-hint=auto > /dev/null 2>&1'
alias socvpn='sudo openfortivpn webvpn.comp.nus.edu.sg --username=e1123003 --password=$(python3 -c "import keyring; print(keyring.get_password(\"soc\", \"e1123003\"))")'
alias xlog='ssh reubenth@xlog.comp.nus.edu.sg'
alias chrome='google-chrome --password-store=gnome-libsecret'
alias typetest='tt -showwpm -notheme -blockcursor'
alias logisim='/home/reuben/cs/CS2100/logisim/launch.sh'
alias usql2102='usql postgres://postgres@localhost/postgres'

# laziness
alias noise='play -n synth brownnoise'
alias yam='/home/reuben/.config/yambar/scripts/launch-yambar.sh'
alias p='wl-paste >'
alias e='exit'
alias t='tmux'

# starship
eval "$(starship init zsh)"

# obsidian
alias obs='cd ~/Documents/Obsidian; nvim .'

# dev services
dev-service() {
  local action=$1
  shift
  for service in docker docker.socket apache2 postgresql forticlient containerd; do
    sudo systemctl "$action" "$service"
  done
}
alias dev-start='dev-service start'
alias dev-stop='dev-service stop'
alias dev-enable='dev-service enable'
alias dev-disable='dev-service disable'
alias activate='source ~/.venv/base/bin/activate'

# vcpkg
alias vcpkg='function _vcpkg_alias(){ /home/reuben/utils/vcpkg/vcpkg "$@"; }; _vcpkg_alias'

# system
alias powerstatus='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias pcipm-enable='echo auto | sudo tee /sys/bus/pci/devices/*/power/control'
alias lume-all='python3 $HOME/.config/scripts/lume.py'
alias lume='ddcutil setvcp 10'
alias gaps='f() { swaymsg gaps inner all set "$1"; swaymsg gaps inner "$1"; }; f'
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

# fnm
FNM_PATH="/home/reuben/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

# zoxide
eval "$(zoxide init zsh)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# java
export PATH_TO_FX="$HOME/.local/share/javafx-sdk-17.0.13/lib"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

# go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# vcpkg
source /home/reuben/utils/vcpkg/scripts/vcpkg_completion.zsh

# dell command-configure
export PATH="/opt/dell/dcc:$PATH"
alias cctk='sudo env PATH=$PATH cctk'
alias charge-express='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Express'
alias charge-dock='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Custom:50-60'
alias charge-std='sudo env PATH=$PATH cctk --PrimaryBattChargeCfg=Standard'
alias thermal-performance='sudo env PATH=$PATH cctk --ThermalManagement=UltraPerformance'
alias thermal-optimized='sudo env PATH=$PATH cctk --ThermalManagement=Optimized'
alias thermal-cool='sudo env PATH=$PATH cctk --ThermalManagement=Cool'

# gradle
export GRADLE_HOME="$HOME/.gradle/wrapper/dists/gradle-8.12.1-bin/eumc4uhoysa37zql93vfjkxy0/gradle-8.12.1"
export PATH="$GRADLE_HOME/bin:$PATH"
alias gradle="$GRADLE_HOME/bin/gradle"

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

# ruby
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# kubeconfig
kubeconf() {
    export KUBECONFIG="$HOME/.kube/$1"
}

# talosconfig
talosconf() {
    export TALOSCONFIG="$HOME/.talos/$1"
}

# zsh-ai, but lazy
help() {
  if [[ -z "$GEMINI_API_KEY" ]]; then
    export GEMINI_API_KEY=$(secret-tool lookup name zsh_ai_gemini_token)
    export ZSH_AI_GEMINI_MODEL="gemini-2.5-flash"
    export ZSH_AI_PROVIDER="gemini"

    source "$ZSH_CUSTOM/plugins/zsh-ai/zsh-ai.plugin.zsh"
  fi

  zsh-ai "$@"
}

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
