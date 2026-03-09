#!/usr/bin/env bash

# Tools and utilities installed via package manager
sudo apt install -y \
    jq \
    ripgrep \
    stow \
    tree

# Tools and utilities installed via source or installers

# Install fzf
SRC_DIR=$HOME/source
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/source/fzf
$HOME/source/fzf/install

# Install pyenv
curl -fsSL https://pyenv.run | bash
