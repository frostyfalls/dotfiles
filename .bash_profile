#!/usr/bin/env bash

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
export NO_AT_BRIDGE=1

export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin:$CARGO_HOME/bin"

[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
[[ "$(tty)" = "/dev/tty2" ]] && ! pgrep river >/dev/null && exec dbus-run-session river >/dev/null 2>&1
