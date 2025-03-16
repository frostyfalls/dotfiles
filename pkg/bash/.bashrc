#!/usr/bin/env bash
# shellcheck disable=SC1091

[[ "$-" != *i* ]] && return

[[ "$HOSTNAME" != "telesto" ]] && PS1='\h ' || PS1=''
PS1="$PS1"'\[\e[0;36m\]\w \[$([[ $? -eq 0 ]] && echo "\e[0;32m" || echo "\e[0;31m")\]\$ \[\e[0m\]'

shopt -s histappend
HISTSIZE=$((2 << 24))
HISTCONTROL="erasedups:ignoreboth"
HISTFILE="$XDG_STATE_HOME/bash_history"

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls -hAF --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias wget='wget --no-hsts'
alias e='$EDITOR'
alias g='git'
alias ll='ls -l'
alias tree='tree --noreport --gitignore'
cd() { builtin cd "$@" && ls; }

ext() {
    [[ -z "$1" ]] && echo "ext: no files" >&2 && return 1
    for f in "$@"; do
        [[ ! -f "$f" ]] && echo "ext: invalid file: $f" >&2 && return 1
        case "$f" in
            *.tar.bz2) tar xjf "$f" ;;
            *.tar.gz) tar xzf "$f" ;;
            *.bz2) bunzip2 "$f" ;;
            *.rar) rar x "$f" ;;
            *.gz) gunzip "$f" ;;
            *.tar) tar xf "$f" ;;
            *.tbz2) tar xjf "$f" ;;
            *.tgz) tar xzf "$f" ;;
            *.zip) unzip "$f" ;;
            *.Z) uncompress "$f" ;;
            *.7z) 7z x "$f" ;;
            *) echo "ext: invalid archive: $f" >&2 && return 1 ;;
        esac
    done
}

complete -cf doas
