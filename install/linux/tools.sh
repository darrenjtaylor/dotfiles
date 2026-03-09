#!/usr/bin/env bash

# Tools and utilities installed via package manager
sudo apt install -y \
    jq \
    ripgrep \
    stow \
    tree

# Tools and utilities installed via source
SRC_DIR=$HOME/source
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/source/fzf
$HOME/source/fzf/install
