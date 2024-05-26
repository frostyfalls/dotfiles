setopt autocd
setopt nocaseglob
setopt histverify
setopt correct
setopt histreduceblanks

HISTSIZE=999999999
SAVEHIST=$HISTSIZE
HISTFILE="$XDG_CACHE_HOME/zsh/history"

PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

[ -f "$XDG_CONFIG_HOME/shell/aliases" ] && . "$XDG_CONFIG_HOME/shell/aliases"
[ -f "$XDG_CONFIG_HOME/shell/shortcuts" ] && . "$XDG_CONFIG_HOME/shell/shortcuts"

if [ -d "$XDG_CONFIG_HOME/shell/functions" ]; then
    for func in "$XDG_CONFIG_HOME"/shell/functions/*; do
        . "$func"
    done
    unset func
fi

if [ -d "$XDG_DATA_HOME/zsh/plugins" ]; then
    for plug in "$XDG_DATA_HOME"/zsh/plugins/*/*.plugin.zsh; do
        . "$plug"
    done
    unset plug
fi
