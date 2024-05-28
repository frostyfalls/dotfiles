# XDG base directories
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"

# Local directories in $PATH
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/.local/bin/runners" ] && export PATH="$PATH:$HOME/.local/bin/runners"
[ -d "$HOME/.local/bin/screenlayouts" ] && export PATH="$PATH:$HOME/.local/bin/screenlayouts"
[ -d "$HOME/.local/bin/statusbar" ] && export PATH="$PATH:$HOME/.local/bin/statusbar"

# Default programs
export TERMINAL="${TERMINAL:-st}"
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-codium}"
export BROWSER="${BROWSER:-qutebrowser}"

# $HOME cleanup
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# Generate shortcuts if none exist and the script is in $PATH
[ ! -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && [ -x "$(command -v shortcuts)" ] && shortcuts

# Automatically start X session inside tty1
[ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec startx
