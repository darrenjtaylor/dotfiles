#!/usr/bin/env bash

# Install dependencies before we build from source.
sudo apt install ninja-build gettext cmake curl build-essential -y

VERSION="v0.11.2"
SRC_DIR=$HOME/source/neovim

# Cleanup neovim source if it already exists.
if [ -d $SRC_DIR ]; then
    rm -rf $SRC_DIR
fi

# Fetch the latest source.
git clone --single-branch --branch $VERSION https://github.com/neovim/neovim.git $SRC_DIR

# Install from source.
pushd $SRC_DIR
make CMAKE_BUILD_TYPE=Release
sudo make install
popd
