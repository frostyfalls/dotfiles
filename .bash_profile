#!/usr/bin/env bash

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
# shellcheck disable=SC2155
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

export TERMINAL="footclient"
export EDITOR="nvim"
export BROWSER="qutebrowser"

export HISTFILE="$XDG_STATE_HOME/bash_history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export PATH="$PATH:$GOPATH/bin:$CARGO_HOME/bin:$HOME/.local/bin"

mkdir -p "$XDG_RUNTIME_DIR"

[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
[[ "$(tty)" == "/dev/tty2" ]] && exec dwl -s "$XDG_CONFIG_HOME/dwl/exec"
