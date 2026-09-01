[[ $- != *i* ]] && return

HISTSIZE=10000
HISTCONTROL="ignoreboth"
PS1='[\u@\h:\W]\$ '

alias ls='ls -AF'
alias ll='ls -lah'
alias tree='tree -n --noreport'
alias gdb='gdb -q'
alias t='tmux new -As 0'
