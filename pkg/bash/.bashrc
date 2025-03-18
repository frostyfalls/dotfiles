#!/usr/bin/env bash
# shellcheck disable=SC1091

[[ $- != *i* ]] && return

if [ -n "$SSH_TTY" ]; then
    PS1='\[\e[0;31m\]\h \[\e[0;34m\]\w \[$([[ $? -eq 0 ]] && echo "\e[0;32m" || echo "\e[0;31m")\]\$ \[\e[0m\]'
else
    PS1='\[\e[0;35m\]\h \[\e[0;34m\]\w \[$([[ $? -eq 0 ]] && echo "\e[0;32m" || echo "\e[0;31m")\]\$ \[\e[0m\]'
fi

shopt -s histappend
HISTSIZE="$((2 << 24))"
HISTCONTROL="erasedups:ignoreboth"
[[ ! -d "$XDG_STATE_HOME/bash" ]] && mkdir -p "$XDG_STATE_HOME/bash"
HISTFILE="$XDG_STATE_HOME/bash/history"

alias cp='cp -iv'
alias mv='mv -iv'
case "$(hostname)" in
    glacier)
        alias rm='rm -iv'
        ;;
    *)
        alias rm='rm -vI'
        ;;
esac
alias mkdir='mkdir -pv'
alias ls='ls -hAF --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias wget='wget --no-hsts'
alias tree='tree --noreport --gitignore'
alias e='$EDITOR'
alias g='git'
alias ll='ls -l'
cd() { builtin cd "$@" && ls; }

command -v doas >/dev/null &&
    complete -cf doas

[ -d "$XDG_DATA_HOME/venv" ] &&
    VIRTUAL_ENV_DISABLE_PROMPT=1 . "$XDG_DATA_HOME/venv/bin/activate"

ext() {
    [[ -z $1 ]] && echo "ext: no files" >&2 && return 1
    for f in "$@"; do
        [[ ! -f $f ]] && echo "ext: invalid file: $f" >&2 && return 1
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
