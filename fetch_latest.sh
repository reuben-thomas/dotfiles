#!/bin/bash

# Config Directory
dotfiles_directory=$(dirname "$(realpath "$BASH_SOURCE")")
echo "Copying latest to $dotfiles_directory ..."
rm -rf "$dotfiles_directory"/.config
rm -rf "$dotfiles_directory"/scripts
cp -rf ~/.config "$dotfiles_directory"
cd "$dotfiles_directory"
git clean --quiet -Xdf
echo "Fetched latest .config directory"

# Scripts Directory
cp -rf ~/.config/scripts/ "$dotfiles_directory"
echo "Fetched latest scripts"

# Vim and Tmux
cp ~/.vimrc "$dotfiles_directory"
cp ~/.tmux.conf "$dotfiles_directory"
cp ~/.bashrc "$dotfiles_directory"
cp ~/.profile "$dotfiles_directory"
echo "Fetched latest .vimrc, .bashrc, .tmux.conf"
