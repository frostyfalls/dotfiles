#!/usr/bin/env bash

# XDG base directories
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Default programs
export TERMINAL="st"
export EDITOR="vim"
export BROWSER="qutebrowser"

# $HOME cleanup
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

export NO_AT_BRIDGE=1
export PATH="$PATH:$GOPATH/bin:$CARGO_HOME/bin:$HOME/.local/bin"

(pgrep -x gpg-agent >/dev/null || gpg-agent --daemon) &>/dev/null
(pgrep -x mpd >/dev/null || mpd) &>/dev/null
(pgrep -x mpdscribble >/dev/null || mpdscribble) &>/dev/null

[[ "$(tty)" == "/dev/tty2" ]] && ! pgrep river >/dev/null && exec dbus-run-session river >/dev/null 2>&1
[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
