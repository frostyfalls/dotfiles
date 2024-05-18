shopt -s autocd
shopt -s nocaseglob
shopt -s histverify

PS1='\[\033[34m\]\w $(if [ "$?" -eq 0 ]; then printf "\033[32m"; else printf "\033[31m"; fi)\$ \[\033[0m\]'

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"

if [ -d "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions" ]; then
    for func in "${XDG_CONFIG_HOME:-$HOME/.config}"/shell/functions/*; do
        . "$func"
    done
    unset func
fi
