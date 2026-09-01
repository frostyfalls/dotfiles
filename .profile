export VISUAL="vi"
export LANG="en_US.UTF-8"
export PATH="$HOME/bin:$PATH"
if [ "$(ps -o command= p 1)" = "runit" ]; then
	export SVDIR="$HOME/.config/service"
fi
if [ -n "$BASH_VERSION" ]; then
	. "$HOME/.bashrc"
fi
