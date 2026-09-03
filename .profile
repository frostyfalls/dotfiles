export LANG="en_US.UTF-8"
export EDITOR="nvim"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export GOPROXY="direct"
export GOSUMDB="off"
export GOTELEMETRY="off"
export GOTOOLCHAIN="local"

if [ -d "$HOME/.local/bin" ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

if [ "$(ps -o command= p 1)" = "runit" ]; then
	export SVDIR="$XDG_CONFIG_HOME/service"
fi

if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

if [ "$(tty)" = "/dev/tty2" ]; then
	exec sway >/dev/null 2>&1
fi
