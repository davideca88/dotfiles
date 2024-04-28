#
# ~/.bashrc
#

XDG_CONFIG_HOME=$HOME/.config

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias lh='ls -l'
alias la='ls -a'
alias lah='ls -lah'
alias neofetch='neofetch --colors 4 4 4 4 --ascii_colors 4 4 4 4'
alias nv='nvim'
alias cl='clear'
alias x='exit'

#PS1='[\u@\h \W]\$ '
# BASHLINE config -------------------------------------------------------------------
function prompt_command {
    STATUS=$?
    export PS1=$($HOME/.config/bashline/bashline.sh $STATUS)
}

[[ -e "$HOME/.config/bashline/bashline.sh" ]] && export PROMPT_COMMAND=prompt_command
# End of BASHLINE config ------------------------------------------------------------
