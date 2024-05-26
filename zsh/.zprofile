[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environment" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environment"

[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && shortcuts

[ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec startx
