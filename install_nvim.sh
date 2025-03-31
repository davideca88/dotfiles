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
mkdir -p $HOME/.config/nvim/
curl https://raw.githubusercontent.com/davideca88/dotfiles/refs/heads/master/init.lua > $HOME/.config/nvim/init.lua

# Install Meslo NerdFont

mkdir -p $HOME/.local/share/fonts/ &&\
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf \
-O $HOME/.local/share/fonts/MesloLGSNFRegular.ttf
fc-cache -fv

# Install clangd for c/c++

cd $HOME
wget https://github.com/clangd/clangd/releases/download/20.1.0/clangd-linux-20.1.0.zip \
    -O clangd.zip && \
unzip clangd.zip && \
cd clangd_20.1.0 && \
cp bin/* $HOME/.local/bin && \
mkdir -p $HOME/.local/lib && \
cp lib/* $HOME/.local/lib && \
printf "\n\n clangd instalado \n\n"

