#!/bin/bash

# Config Directory
dotfiles_directory=$(dirname "$(realpath "$BASH_SOURCE")")
rm -rf "$dotfiles_directory"/.config
cp -rf ~/.config "$dotfiles_directory"
cd "$dotfiles_directory"
git clean --quiet -Xdf
echo "Updated contents of .config directory and copied to $dotfiles_directory"

# Vim and Tmux
cp ~/.vimrc "$dotfiles_directory"
cp ~/.tmux.conf "$dotfiles_directory"
cp ~/.bashrc "$dotfiles_directory"
echo "Updated latest .vimrc and .tmux.conf and copied to $dotfiles_directory"






