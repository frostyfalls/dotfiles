#!/usr/bin/env bash
# shellcheck disable=SC1091

[[ "$-" != *i* ]] && return

[[ "$EUID" -ne 0 ]] && PROMPT_DIRTRIM=3
PS1="\[\e[1;32m\]\u\[\e[1;33m\]@\[\e[1;35m\]\h \[\e[1;34m\]\w \[\e[0;0m\]% "

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
