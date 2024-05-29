[[ $- != *i* ]] && return

shopt -s autocd
shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist
set -o noclobber

HISTFILESIZE=100000
export HISTCONTROL="ignoredups"

git_branch() {
  branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
  if [ ! -z "$branch" ]; then
    if [ -n "$(git status --porcelain)" ]; then
      color="31"  # Red for changes
    elif [ "$(git stash list)" ]; then
      color="33"  # Yellow for stashed changes
    else
      color="32"  # Green for a clean state
    fi
    echo -e "\\e[0;${color}m${branch}\\e[0m"  
  fi
}

PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w \[\e[1;33m\]\$(git_branch) \[\e[0m\]\$ '

[ -f "$XDG_CONFIG_HOME/shell/shortcuts" ] && . "$XDG_CONFIG_HOME/shell/shortcuts"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias bat='bat --style=plain'
alias xdg-ninja='xdg-ninja --skip-unsupported'

alias sudo='doas'
alias vim='nvim'
alias code='codium'
alias fetch='fastfetch'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkdir='mkdir -pv'

alias df='df -h'
alias free='free -h'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

skinstall() {
    rm config.h
    make || return
    doas make install
}

ex() {
    if [ -n "$1" ] && [ -f "$1" ]; then
        case $1 in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *) echo "unknown archive type" ;;
        esac
    elif [ -n "$1" ]; then
        echo "file not found"
    fi
}
