# shellcheck disable=SC2155

[ -f "$HOME/.zshrc" ] && . "$HOME/.zshrc"

# XDG base directories
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Default programs
export TERMINAL="${TERMINAL:-st}"
export EDITOR="${EDITOR:-nvim}"
export BROWSER="${BROWSER:-firefox}"

# $HOME cleanup
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

# Other program settings
export SVDIR="$XDG_CONFIG_HOME/service"
export PIPX_BIN_DIR="$XDG_DATA_HOME/pipx/bin"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# $PATH additions
export PATH="$PATH:$(find "$HOME/.local/bin/" -type d | paste -sd ':' -)"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$XDG_DATA_HOME/pipx/bin"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"

# Automatic graphical start on tty1
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx
