#!/usr/bin/env sh

FONT_DIR="${HOME}/.fonts/"

cat dotfiles/bashrc >> $HOME/.bashrc

# Create ~/.config and put init.lua
mkdir -p $HOME/.config/nvim/
cp dotfiles/init.lua $HOME/.config/nvim/init.lua

# Devcontainer stuff
mkdir -p ~/.config/nvim/devcontainer/ \
    && cp -r dotfiles/devcontainer/* ~/.config/nvim/devcontainer/

# Install Meslo NerdFont
mkdir -p $FONT_DIR && \
cp dotfiles/font.ttf $FONT_DIR && \
fc-cache -f && \
fc-cache -r

# If wants to clean install dotfiles, remove the directory
if [ "$1" = "clean" ]; then
    rm -rf dotfiles
    echo "Dotfiles dir deleted ;)"
fi
