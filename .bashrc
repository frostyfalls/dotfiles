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

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'

alias ls='ls --color=auto -AF'
alias grep='grep --color=auto'

cd() { builtin cd "$@" && ls; }
lf() { cd "$(command lf -print-last-dir "$@")" || return; }
mkcd() { mkdir -p "$*" && cd "$*" || return 1; }

alias cat='bat'
alias vim='nvim'

alias em='emacs -nw'
alias emacs='emacsclient -ca emacs'

alias wget='wget --no-hsts'

alias l='ls'
alias t='tmux'
alias v='nvim'
alias g='git'
alias py='python'

alias ll='ls -l'

alias ge='git clone'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gg='git log'

HISTFILE="${XDG_STATE_HOME}/bash_history"
HISTSIZE="$((2 << 15))" HISTFILESIZE="${HISTSIZE}"
HISTCONTROL="erasedups:ignoreboth"
shopt -s histappend

[[ -d "${XDG_DATA_HOME}/venv" ]] &&
    VIRTUAL_ENV_DISABLE_PROMPT=1 . "${XDG_DATA_HOME}/venv/bin/activate"

PROMPT_COL_SUCCESS='\[\e[1;37m\]'
PROMPT_COL_USER_HOST='\[\e[1;32m\]'
PROMPT_COL_ROOT='\[\e[1;31m\]'
PROMPT_COL_WORK_DIR='\[\e[1;34m\]'
PROMPT_COL_FAILURE='\[\e[1;31m\]'

[[ "${EUID}" -ne 0 ]] && PROMPT_DIRTRIM=3
PROMPT_COMMAND='__prompt'
