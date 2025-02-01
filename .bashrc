#!/usr/bin/env bash
# shellcheck disable=SC1091

[[ "$-" != *i* ]] && return

__prompt() {
    exitc="$?"
    if [[ "$exitc" -eq 0 ]]; then
        symbol_color="\[\e[0;92m\]"
    else
        symbol_color="\[\e[0;91m\]"
    fi
    PS1="\[\e[0;96m\]\u\[\e[0;97m\]@\[\e[0;95m\]\h \[\e[0;94m\]\w $symbol_color❯ \[\e[0;0m\]"
}

[[ "$EUID" -ne 0 ]] && PROMPT_DIRTRIM=3
PROMPT_COMMAND=__prompt

HISTFILE="$XDG_STATE_HOME/bash_history"
HISTSIZE="$((2 << 15))"
HISTFILESIZE="$HISTSIZE"
HISTCONTROL="erasedups:ignoreboth"
shopt -s histappend

[[ -d "$XDG_DATA_HOME/venv" ]] && command -v python >/dev/null && VIRTUAL_ENV_DISABLE_PROMPT=1 . "$XDG_DATA_HOME/venv/bin/activate"

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls --color=auto -AF'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias wget='wget --no-hsts'
alias tmux='tmux -2'
cd() { builtin cd "$@" && ls; }
lf() { cd "$(command lf -print-last-dir "$@")" || return; }

alias vim='nvim'
alias t='tmux'
alias e='$EDITOR'
alias g='git'
alias ll='ls -l'
alias ge='git clone'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gg='git log'
