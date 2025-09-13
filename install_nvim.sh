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

sh ./install.sh
