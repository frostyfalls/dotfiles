#!/usr/bin/env bash

[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Default options
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls --color=auto -AF'
alias grep='grep --color=auto'
alias wget='wget --no-hsts'

# Utilities
alias ipp='curl https://ipinfo.io/ip && echo'
ipl() {
    if address=$(ip route get 1 2>/dev/null); then
        address=${address#* via * dev * src }
        address=${address% uid *}
    fi

    [ -n "$address" ] && echo "$address" || echo "Offline"
}

cd() { builtin cd "$@" && ls; }

alias vim='nvim'

# Shorthands
alias l='ls'
alias t='tmux'
alias v='vim'
alias g='git'
alias f='fastfetch'

# Commands or options
alias ll='ls -l'
alias ge='git clone'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gg='git log'
