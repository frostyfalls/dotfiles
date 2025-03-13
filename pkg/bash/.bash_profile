#!/usr/bin/env bash
# shellcheck disable=SC1091

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

for dir in "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"; do
    [[ ! -d "$dir" ]] && mkdir -p "$dir"
done

export EDITOR="emacsclient -ca emacs"
export TERMINAL="footclient"
export BROWSER="firefox"

export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export SVDIR="$XDG_CONFIG_HOME/service"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

for dir in "$HOME/.local/bin" "$GOPATH/bin" "$CARGO_HOME/bin"; do
    [[ -d "$dir" ]] && PATH="$PATH:$dir"
done
unset dir
export PATH

[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

if [[ "$(tty)" = "/dev/tty2" ]] && ! pgrep sway >/dev/null; then
    export XDG_CURRENT_DESKTOP="sway"
    eval "$(ssh-agent -D -a "$SSH_AUTH_SOCK")" &
    exec dbus-run-session sway >/dev/null 2>&1
fi
