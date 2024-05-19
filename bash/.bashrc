PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

# shellcheck disable=SC1091
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"

if [ -d "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions" ]; then
    for func in "${XDG_CONFIG_HOME:-$HOME/.config}"/shell/functions/*; do
        # shellcheck disable=SC1090
        . "$func"
    done
    unset func
fi
