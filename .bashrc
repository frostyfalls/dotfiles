# shellcheck shell=sh

case $- in
*i*) ;;
*) return ;;
esac

lfcd() {
	cd "$(command lf -print-last-dir "$@")" || return
}

# Default options
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls --color=auto -AF'
cd() { builtin cd "$@" && ls; }
alias grep='grep --color=auto'
alias wget='wget --no-hsts'
alias vim='nvim'

# Utilities
alias ipp='curl https://ipinfo.io/ip && echo'
ipl() {
	if address="$(ip route get 1 2>/dev/null)"; then
		address="${address#* via * dev * src }"
		address="${address% uid *}"
	fi

	if [ -n "$address" ]; then
		printf '%s' "$address"
	else
		printf 'Offline'
	fi
	printf '\n'
}

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

if [ -d "$XDG_DATA_HOME/bash/iceline" ]; then
	. "$XDG_DATA_HOME/bash/iceline/iceline.sh"
	PROMPT_COMMAND='_prompt_command'
fi
