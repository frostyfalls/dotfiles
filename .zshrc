case "$-" in
*i*) ;;
*) return ;;
esac

# Completion options
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
zstyle ':completion:*' completer _expand_alias _complete _ignored

## History options ##
HISTSIZE=100000
HISTFILESIZE="$HISTSIZE"

setopt autocd
setopt promptsubst

# Default options
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'
alias ls='ls --color=auto -AF'
alias grep='grep --color=auto'
alias wget='wget --no-hsts-file'
cd() {
    builtin cd "$@" && ls
}

# Public and private IP addresses
alias ipp='curl https://ipinfo.io/ip && echo'
alias ipl='monitors local_ip'

# Shorthands
alias l='ls'
alias c='cd'
alias v='nvim'
alias vim='nvim'
alias g='git'
alias ff='fastfetch'
alias fetch='fastfetch'

# Other options or commands
alias ll='ls -l'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gp='git push'
alias gl='git pull'

parse_git_branch() {
    command -v git >/dev/null 2>&1 || return

    git_branch=$(git branch --no-color 2>/dev/null)
    [ -z "$git_branch" ] && return
    is_dirty=$(git status --porcelain 2>/dev/null)
    [ -n "$is_dirty" ] && color="red" || color="magenta"

    printf '%s' " %F{${color}}${git_branch#* }"
}

## Prompts ##
PROMPT="
%F{green}%n@%M %F{blue}%~\$(parse_git_branch) %F{reset}%% "
RPROMPT='%F{white}%*%F{reset}'

## External loading ##
if [ -d "$XDG_DATA_HOME/zsh/plugins" ]; then
	for p in "$XDG_DATA_HOME"/zsh/plugins/*/*.plugin.zsh; do
		. "$p"
	done
	unset p
fi
