case "$-" in
*i*) ;;
*) return ;;
esac

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

export HISTFILE="$XDG_STATE_HOME/zsh/history"

export HISTSIZE=100000
export HISTFILESIZE="$HISTSIZE"

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_NO_STORE

alias v='nvim'
alias vim='nvim'

alias ll='ls -lAF'
alias la='ls -AF'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wget="wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"

alias ipp='curl https://ipinfo.io/ip && echo'
alias ipl='monitors local_ip'

## Initialization ##

PROMPT=$'%{\e[1;32m%}%n@%M%{\e[1;34m%} %~ %%%{\e[0m%} '

clear
fastfetch

if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins" ]; then
	for plugin in "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/plugins/*/*.plugin.zsh; do
		. "$plugin"
	done
	unset plugin
fi
