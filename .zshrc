setopt autocd
setopt nocaseglob
setopt histverify
setopt correct
setopt histreduceblanks

PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"

if [ -d "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions" ]; then
    for func in "${XDG_CONFIG_HOME:-$HOME/.config}"/shell/functions/*; do
        . "$func"
    done
    unset func
fi

if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins" ]; then
    for plug in "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/plugins/*/*.plugin.zsh; do
        # shellcheck disable=SC1090
        . "$plug"
    done
    unset plug
fi
