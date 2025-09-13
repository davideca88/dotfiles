#!/usr/bin/env sh

cat ./bashrc >> $HOME/.bashrc

# Install NeoVim plugin manager (currently paq-nvim)
mkdir -p $HOME/.local/share/
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

# Create ~/.config and put init.lua
mkdir -p $HOME/.config/nvim/
cp ./init.lua $HOME/.config/nvim/init.lua

# Install Meslo NerdFont
mkdir -p $HOME/.local/share/fonts/ &&\
cp ./font.ttf $HOME/.local/share/fonts/MesloLGSNFRegular.ttf
fc-cache -f
fc-cache -r

# If has NeoVim, installs the plugins
if nvim -v &> /dev/null; then
    nvim --headless -c ':PaqInstall | echo "\nPlugins installed =D\n" | :q'
fi

# If wants to clean install dotfiles, remove the directory
if [ "$1" -eq "clean" ]; then
    rm -rf ../dotfiles/
    echo "Dotfiles dir deleted ;)"
fi
