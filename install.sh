#!/bin/bash

# Get all new changes
dotfiles_directory=$(dirname "$(realpath "$BASH_SOURCE")")
rm -rf "$dotfiles_directory"/.config
cp -rf ~/.config "$dotfiles_directory"
echo "The ~/.config directory has been copied to $dotfiles_directory"
# Only allow tracked files
cd "$dotfiles_directory"
git clean --quiet -Xdf




