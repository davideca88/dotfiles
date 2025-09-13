#!/usr/bin/env sh

cat dotfiles/bashrc >> $HOME/.bashrc

# Install NeoVim plugin manager (currently paq-nvim)
mkdir -p $HOME/.local/share/
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

# Create ~/.config and put init.lua
mkdir -p $HOME/.config/nvim/
cp dotfiles/init.lua $HOME/.config/nvim/init.lua

# Install Meslo NerdFont
mkdir -p $HOME/.local/share/fonts/ &&\
cp dotfiles/font.ttf $HOME/.local/share/fonts/MesloLGSNFRegular.ttf
fc-cache -f
fc-cache -r

# If has NeoVim, installs the plugins
if nvim -v &> /dev/null; then
    nvim --headless -c ':PaqInstall | echo "\nPlugins installed =D\n" | :q'
fi

# If wants to clean install dotfiles, remove the directory
if [ "$1" = "clean" ]; then
    rm -rf dotfiles/dotfiles/
    echo "Dotfiles dir deleted ;)"
fi
