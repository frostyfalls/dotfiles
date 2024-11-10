#!/usr/bin/env bash
# shellcheck disable=SC1091

[[ $- != *i* ]] && return

__prompt() {
    _last_exit="$?"
    case "${_last_exit}" in
    0 | 130) _prompt_color="${PROMPT_COL_SUCCESS}" ;;
    *) _prompt_color="${PROMPT_COL_FAILURE}" ;;
    esac

    if [[ "${EUID}" -ne 0 ]]; then
        _user_host="${PROMPT_COL_USER_HOST}\u@\h"
        _prompt_char="%"
    else
        _user_host="${PROMPT_COL_ROOT}\h"
        _prompt_char="#"
    fi

    PS1="${_user_host}\[\e[0;0m\]:${PROMPT_COL_WORK_DIR}\w ${_prompt_color}${_prompt_char} \[\e[0;0m\]"
}

cmd() { command -v "$1" >/dev/null; }

# default options
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls --color=auto -AF'
alias grep='grep --color=auto'

# cd
cd() { builtin cd "$@" && ls; }
lf() { cd "$(command lf -print-last-dir "$@")" || return; }
mkcd() { mkdir -p "$*" && cd "$*" || return 1; }
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
shopt -s autocd

# alternatives
cmd bat && alias cat='bat'
cmd nvim && alias vim='nvim'

# emacs
alias em='emacs -nw'
alias emacs='emacsclient -ca emacs'

# fixes
alias wget='wget --no-hsts'
alias tmux='tmux -2'

# shorthands
alias l='ls'
alias t='tmux'
if cmd nvim; then
    alias v='nvim'
elif cmd vim; then
    alias v='vim'
fi
alias g='git'
alias py='python'

# ls
alias ll='ls -l'

# git
alias ge='git clone'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gg='git log'

# history options
HISTFILE="${XDG_STATE_HOME}/bash_history"
HISTSIZE="$((2 << 15))" HISTFILESIZE="${HISTSIZE}"
HISTCONTROL="erasedups:ignoreboth"
shopt -s histappend

# python venv
[[ -d "${XDG_DATA_HOME}/venv" ]] &&
    VIRTUAL_ENV_DISABLE_PROMPT=1 . "${XDG_DATA_HOME}/venv/bin/activate"

# prompt
PROMPT_COL_SUCCESS='\[\e[1;37m\]'
PROMPT_COL_USER_HOST='\[\e[1;32m\]'
PROMPT_COL_ROOT='\[\e[1;31m\]'
PROMPT_COL_WORK_DIR='\[\e[1;34m\]'
PROMPT_COL_FAILURE='\[\e[1;31m\]'
[[ "${EUID}" -ne 0 ]] && PROMPT_DIRTRIM=3
PROMPT_COMMAND='__prompt'

# interactive functions
ex() {
    [[ ! -f "$1" ]] && return 1
    case "$1" in
    *.tar.bz2) tar xvjf "$1" ;;
    *.tar.gz) tar xvzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xvf "$1" ;;
    *.tbz2) tar xvjf "$1" ;;
    *.tgz) tar xvzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) return 1 ;;
    esac
}
hf() { eval "$(history | sort -r | fzf | awk '{$1=""; print substr($0,2)}')"; }
alias hg='history | grep'
myip() {
    echo "Public: $(curl -s ipv4.icanhazip.com)"
    echo "Local: $(ip route get 1 | awk 'NR==1{print $7}')"
}
