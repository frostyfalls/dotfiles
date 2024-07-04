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

alias ll='ls -lAF'
alias la='ls -AF'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias v='nvim'

skli() {
	[ -f config.h ] && rm config.h
	make || return
	doas make install
}

ncd() {
	if [ "${NNNLVL:-0}" -ne 0 ]; then
		echo "nnn is already running"
		return
	fi

	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

	command nnn "$@"

	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f -- "$NNN_TMPFILE" >/dev/null
	fi
}

bind '"\C-f": "ncd\r"'
