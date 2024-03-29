# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exisyts.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Run keyring on startup
if [ "$XDG_SESSION_DESKTOP" = "sway" ]; then
	# Do not restart for tmux sessions
	if [ "$TERM" != "tmux-256color" ]; then
		eval $(gnome-keyring-daemon --start)
		export SSH_AUTH_SOCK
	fi
fi

# export directory for scripts
export PATH="$PATH:/home/reuben/.config/scripts"

# Created by `pipx` on 2023-12-13 10:18:49
export PATH="$PATH:/home/reuben/.local/bin"
. "$HOME/.cargo/env"
