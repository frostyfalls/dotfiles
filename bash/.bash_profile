# shellcheck disable=SC1091
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environment" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environment"

export HISTFILE="$XDG_STATE_HOME/bash/history"

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
