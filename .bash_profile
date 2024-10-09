#!/usr/bin/env bash

# XDG base directories
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

# Default programs
export TERMINAL="footclient"
export EDITOR="nvim"
export BROWSER="qutebrowser"
export VISUAL="emacsclient -ca emacs"

# $HOME cleanup
export HISTFILE="${XDG_STATE_HOME}/bash_history"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"
export GOPATH="${XDG_DATA_HOME}/go"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Programs/environment settings
export QT_QPA_PLATFORMTHEME="qt6ct"

# $PATH additions
export PATH="${PATH}:${GOPATH}/bin:${CARGO_HOME}/bin:${HOME}/.local/bin"

[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
[[ "$(tty)" == "/dev/tty2" ]] &&
    ! pgrep river >/dev/null &&
    exec dbus-run-session river >/dev/null 2>&1
:
