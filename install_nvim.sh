#!/bin/env bash

# Made by a human ;)
# Script for easy install and minimal configure NeoVim when I'm out of home

# Install NeoVim locally without super user
cd /tmp && \
git clone https://github.com/neovim/neovim && \
cd neovim && \
git checkout stable && \
make CMAKE_BUILD_TYPE=Release \
     CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local -DLibIntl_LIBRARY=/usr/lib/libintl.so.8 -DLibIntl_INCLUDE_DIR=/usr/include" && \
make install

# Install NeoVim plugin manager (currently paq-nvim)
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

# Create ~/.config and put init.lua
mkdir -p $HOME/.config/
curl https://raw.githubusercontent.com/davideca88/dotfiles/refs/heads/master/light-init.lua > $HOME/.config/nvim/init.lua

# Install NerdFonts
cd /tmp && git clone https://github.com/ryanoasis/nerd-fonts && sh /tmp/nerd-fonts/install.sh
