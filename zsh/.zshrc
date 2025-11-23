export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

zstyle ':omz:update' mode reminder

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

plugins=(
  git
)

eval "$(starship init zsh)"
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-vi-mode/zsh-vi-mode.zsh

# default app overrides
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

# laziness
alias noise='play -n synth brownnoise'
alias rec='/home/reuben/.config/scripts/screencast.sh; cd /home/reuben/Videos/Screencasts/'
alias work='/home/reuben/.config/scripts/work.sh'
alias dock='/home/reuben/.config/scripts/dock.sh'
alias yam='/home/reuben/.config/yambar/scripts/launch-yambar.sh'
alias zoxadd='/home/reuben/.config/scripts/zoxide-add.sh'
alias p='wl-paste >'
alias e='exit'
alias t='tmux'

# obsidian
alias obs='cd ~/Documents/Obsidian; nvim .'
alias note='cd ~/Documents/Note; nvim .'

# dev services
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

# system
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
eval "$(zoxide init zsh)"

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
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
