# shellcheck disable=SC1091
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environment" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environment"

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
