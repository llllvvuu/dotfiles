export CLICOLOR=1
export GPG_TTY=$(tty)
export HISTSIZE=10000
export SAVEHIST=20000
export LD_LIBRARY_PATH="$HOME/lib64:$HOME/lib:$LD_LIBRARY_PATH"
export PS1="; "

[ -s $HOME/.ssh/environment ] && . $HOME/.ssh/environment

command -v vim &>/dev/null && export EDITOR="vim"
command -v nvim &>/dev/null && export EDITOR="nvim"

# vim: set ft=sh:
