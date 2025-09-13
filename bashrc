#
# Deca's ~/.bashrc main parts
#

export PATH=$HOME/.local/bin:$PATH

# USB stick called
export USB_STICK=/run/media/deca/

NVIM_CONFIG_FILE=$HOME/.config/nvim/init.lua
XDG_CONFIG_HOME=$HOME/.config

alias ls='ls --color=auto'
alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -a'
alias lah='ls -lah'
alias cl='clear'
alias x='exit'

alias asmr='w3m https://www.felixcloutier.com/x86/'
alias syscallstbl='w3m https://syscalls.w3challs.com/?arch=x86_64'
alias gdb='gdb -q'
alias neofetch='neofetch --colors 4 4 4 4 --ascii_colors 4 4 4 4'
alias n='nvim'
alias nv='nvim'
alias py='python3'

# end of the main parts
