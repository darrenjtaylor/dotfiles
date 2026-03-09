#!/usr/bin/env bash

##############################################################################
# Tools and utilities installed via package manager
##############################################################################


packages=(
    # Direct-use tools
    jq
    ripgrep
    stow
    tree
    # Dependencies to build and install versions of Python with pyenv
    # Most of these will likely already be installed, but if we're 
    # installing pyenv we might as well make sure we can definitely
    # build and install Python from source.
    make
    build-essential
    libssl-dev
    zlib1g-dev
    libbz2-dev
    libreadline-dev
    libsqlite3-dev
    curl
    git
    libncursesw5-dev
    xz-utils
    tk-dev
    libxml2-dev
    libxmlsec1-dev
    libffi-dev
    liblzma-dev
)
sudo apt update
sudo apt install -y "${packages[@]}"


##############################################################################
# Tools and utilities installed via source or installers
##############################################################################


# Install fzf
SRC_DIR=$HOME/source
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/source/fzf
$HOME/source/fzf/install

# Install pyenv
curl -fsSL https://pyenv.run | bash
