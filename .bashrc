#!/usr/bin/env bash
# shellcheck disable=SC1091

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
cd() { builtin cd "$@" && ls; }

# Alternative programs
alias cat='bat'
alias vim='nvim'

# Shorthands
alias c='cd'
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

# Python virtual environment
[[ -d "${XDG_DATA_HOME}/venv" ]] &&
    VIRTUAL_ENV_DISABLE_PROMPT=1 . "${XDG_DATA_HOME}/venv/bin/activate"
