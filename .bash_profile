#!/usr/bin/env bash

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

export XDG_DESKTOP_DIR="${HOME}"
export XDG_DOCUMENTS_DIR="${HOME}/documents"
export XDG_DOWNLOAD_DIR="${HOME}/downloads"
export XDG_MUSIC_DIR="${HOME}/music"
export XDG_PICTURES_DIR="${HOME}/pictures"
export XDG_PUBLICSHARE_DIR="${HOME}/public"
export XDG_TEMPLATES_DIR="${HOME}/templates"
export XDG_VIDEOS_DIR="${HOME}/videos"
export XDG_SCREENSHOTS_DIR="${HOME}/pictures/screenshots"

export TERMINAL="footclient"
export EDITOR="nvim"
export BROWSER="qutebrowser"

export HISTFILE="${XDG_STATE_HOME}/bash_history"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"
export GOPATH="${XDG_DATA_HOME}/go"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

export PATH="${PATH}:${GOPATH}/bin:${CARGO_HOME}/bin:${HOME}/.local/bin"

[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"

[[ "$(tty || :)" == "/dev/tty2" ]] &&
    ! pgrep river >/dev/null &&
    exec dbus-run-session river 2>/dev/null
