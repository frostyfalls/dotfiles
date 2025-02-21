#!/usr/bin/env bash
# shellcheck disable=SC1091

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR="nvim"
export TERMINAL="footclient"
export BROWSER="qutebrowser"

export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export SVDIR="$XDG_CONFIG_HOME/service"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

for dir in "$HOME/.local/bin" "$GOPATH/bin" "$CARGO_HOME/bin"; do
    [[ -d "$dir" ]] && PATH="$PATH:$dir"
done
unset dir
export PATH

[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

if [[ "$(tty)" = "/dev/tty2" ]] && ! pgrep sway >/dev/null; then
    export XDG_CURRENT_DESKTOP="sway:wlroots"
    eval "$(ssh-agent -D -a "$SSH_AUTH_SOCK")" &
    exec dbus-run-session sway >/dev/null 2>&1
fi
