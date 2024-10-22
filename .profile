#!/bin/sh

# XDG base directories
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

# Default programs
export TERMINAL="footclient"
export EDITOR="nvim"
export BROWSER="qutebrowser"

# $HOME cleanup
export GOPATH="${XDG_DATA_HOME}/go"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"

# Qt theme settings
if command -v qt6ct >/dev/null; then
    export QT_QPA_PLATFORMTHEME="qt6ct"
elif command -v qt5ct >/dev/null; then
    export QT_QPA_PLATFORMTHEME="qt5ct"
fi

# $PATH additions
export PATH="${PATH}:${GOPATH}/bin:${CARGO_HOME}/bin:${HOME}/.local/bin"

# Graphical session
if [ "$(tty)" = "/dev/tty2" ] && ! pgrep river >/dev/null; then
    exec env XDG_CURRENT_DESKTOP="river" \
        dbus-run-session river >/dev/null 2>&1
fi
