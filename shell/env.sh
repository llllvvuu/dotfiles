CLICOLOR=1
GPG_TTY=$(tty)
HISTSIZE=10000
SAVEHIST=20000
LD_LIBRARY_PATH="$HOME/lib64:$HOME/lib:$LD_LIBRARY_PATH"
PS1="; "

[ -s $HOME/.ssh/environment ] && . $HOME/.ssh/environment

command -v vim &>/dev/null && EDITOR="vim"
command -v nvim &>/dev/null && EDITOR="nvim"

# vim: set ft=sh:
