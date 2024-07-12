case "$-" in
*i*) ;;
*) return ;;
esac

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

shopt -s autocd

HISTFILESIZE=100000
HISTCONTROL="ignoredups"

alias v='nvim'

alias ll='ls -lAF'
alias la='ls -AF'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

skli() {
	[ -f config.h ] && rm config.h
	make || return
	doas make install
}
