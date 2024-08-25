# shellcheck shell=sh

case "$-" in
*i*) ;;
*) return ;;
esac

export HISTFILE="$XDG_STATE_HOME/bash/history"

lfcd() {
    cd "$(command lf -print-last-dir "$@")" || return
}

# Default options
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias lf='lfub'
alias ls='ls --color=auto -AF'
cd() {
    builtin cd "$@" && ls
}
alias grep='grep --color=auto'
# alias wget='wget --no-hsts-file'
alias vim='nvim'

# Utilities
alias ipp='curl https://ipinfo.io/ip && echo'
alias ipl='monitors local_ip'

# Shorthands
alias l='ls'
alias t='tmux'
alias c='cd'
alias v='nvim'
alias g='git'
alias ff='fastfetch'

# Commands or options
alias ll='ls -l'
alias ge='git clone'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'

. ~/docs/repos/iceline/iceline.sh
