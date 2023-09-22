export CLICOLOR=1
export GPG_TTY=$(tty)
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTFILESIZE=10000000
export LD_LIBRARY_PATH="$HOME/lib64:$HOME/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/bin:$HOME/local/bin:$PATH"
export PS1="; "
export FZF_CTRL_T_COMMAND="git-ls.sh"

[ -s $HOME/.ssh/environment ] && . $HOME/.ssh/environment

command -v vim &>/dev/null && export EDITOR="vim"
command -v nvim &>/dev/null && export EDITOR="nvim"

# vim: set ft=sh:
