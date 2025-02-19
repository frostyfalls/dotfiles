#!/usr/bin/env bash
# shellcheck disable=SC1091

[[ "$-" != *i* ]] && return

PS1='\[\e[0;36m\]\w \[$([[ $? -eq 0 ]] && echo "\e[0;32m" || echo "\e[0;31m")\]\$ \[\e[0m\]'

shopt -s histappend
HISTSIZE=$((2 << 24))
HISTCONTROL=erasedups:ignoreboth
HISTFILE="$XDG_STATE_HOME/bash_history"

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls -AF --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias wget='wget --no-hsts'
alias e='$EDITOR'
alias g='git'
alias ll='ls -l'
cd() { builtin cd "$@" && ls; }

complete -cf doas
