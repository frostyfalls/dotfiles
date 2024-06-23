case "$-" in
	*i*) ;;
	*) return ;;
esac

shopt -s autocd

HISTFILESIZE=100000
HISTCONTROL="ignoredups"

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

skli() {
    rm config.h
    make || return
    doas make install
}
