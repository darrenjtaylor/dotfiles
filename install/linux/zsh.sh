#!/usr/bin/env bash

sudo apt install -y zsh
chsh -s $(which zsh)

# Symlink zsh and zim configuration files.
stow -t $HOME zsh

# Install zim to manage zsh configuration.
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

