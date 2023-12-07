#!/bin/bash

# Config Directory
dotfiles_directory=$(dirname "$(realpath "$BASH_SOURCE")")
rm -rf "$dotfiles_directory"/.config
cp -rf ~/.config "$dotfiles_directory"
echo "The ~/.config directory has been copied to $dotfiles_directory"
cd "$dotfiles_directory"
git clean --quiet -Xdf

# Vim and Tmux
cp ~/.vimrc "$dotfiles_directory"
cp ~/.tmux.conf "$dotfiles_directory"






