# dotfiles
Perpetual work in progress

## Setup

Setting up an Ubuntu 24.04 system from a fresh state.  I used these steps to setup Kubuntu 24.04 on my Framework laptop.  Eventually I will automate these steps into a script or ansible playbook, but I typically don't start a fresh installation very often so it's not a priority.

### Update

    sudo apt update && sudo apt upgrade

### Install build essentials

These will be needed later on since treesitter and some other utilities require a C compiler.  Might as well get them installed now.

    sudo apt install build-essential

### Install CURL

    sudo apt install curl

### Install zsh

If `zsh --version` results in command not found, you'll have to install zsh first:

    sudo apt install zsh

Make `zsh` your default shell:

    chsh -s $(which zsh)

You'll probably have to logout and log back in for it to take effect.  Opening a terminal afterwards will prompt you to configure zsh, you can `q` out of this for now since we're going to install and configure things with `ohmyposh` next.

### Install ohmyposh

    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

TODO: Create a config json file in this repo and pass it in to oh-my-posh init with `--config`

### Install docker

There's a couple different ways to install docker.  If you need the latest and greatest, refer to the instructions on the official docker site, which has you setup appropriate repository.  If you just need docker and don't really care if it's the latest, you can use the following:

    sudo apt install docker.io

Once installed, you'll probably get complaints about permissions.  You need to create the `docker` group if it isn't already created:

    sudo groupadd docker

And then add your user to the `docker` group:

    sudo usermod -aG docker $USER

### Install fzf
### Install neovim

* Go to the latest releases page here: https://github.com/neovim/neovim/releases
* Download the appimage for the latest version
* `chmod u+x` the file and move it to your appimages directory (i.e. `$HOME/.appimages/neovim/`)
* Symlink it to `/usr/bin/nvim` (i.e. `sudo ln -s $HOME/.appimages/neovim/nvim.appimage /usr/bin/nvim`)
* Make sure you have `$HOME/.config/nvim` symlinked to this repo's `.config/nvim`
* On first startup, lazy will install all your packages, you may need to install `node` in order to get the LSP's installed

### Install tmux

* Go to the latest releases page here: https://github.com/nelsonenzo/tmux-appimage/releases
* Download the appimage for the latest version
* `chmod u+x` the file and move it to your appimages directory (i.e. `$HOME/.appimages/tmux/`)
* Symlink it to `/usr/bin/tmux` (i.e. `sudo ln -s $HOME/.appimages/tmux/tmux.appimage /usr/bin/tmux`)
* Make sure you have `$HOME/.config/tmux` symlinked to this repo's `.config/tmux`
* Install tpm by cloning: `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`
* Start `tmux` and install plugins <prefix> + I (`Ctrl + s` `Shift + i`)

### Install pyenv
