#
# ~/.bashrc
#

export PATH=$HOME/.local/bin:$PATH

# USB stick called
export USB_STICK=/run/media/deca/

NVIM_CONFIG_FILE=$HOME/.config/nvim/init.lua
XDG_CONFIG_HOME=$HOME/.config

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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


#PS1='[\u@\h \W]\$ '
# BASHLINE config -------------------------------------------------------------------
function prompt_command {
    STATUS=$?
    export PS1=$($HOME/.config/bashline/bashline.sh $STATUS)
}

[[ -e "$HOME/.config/bashline/bashline.sh" ]] && export PROMPT_COMMAND=prompt_command
# End of BASHLINE config ------------------------------------------------------------
