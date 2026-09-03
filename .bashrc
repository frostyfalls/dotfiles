[[ $- != *i* ]] && return

HISTCONTROL='ignoredups:ignorespace'
HISTSIZE=10000

__prompt() {
	local ret=$?
	unset PS1
	[ $ret != 0 ] && PS1="$ret "
	PS1+='[\u@\h:\W]\$ '
}
PROMPT_COMMAND='__prompt'

alias ls='ls -AF'
alias ll='ls -alh'
alias gdb='gdb -q'
alias tree='tree -n --noreport'

alias t='tmux new -As 0'

if command -v nvim >/dev/null; then
	alias vi='nvim'
	alias vim='nvim'
fi

export GPG_TTY="$(tty)"
