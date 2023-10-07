#!/bin/sh
#
export CLICOLOR=1
GPG_TTY="$(tty)"
export GPG_TTY
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTFILESIZE=10000000
export LD_LIBRARY_PATH="$HOME/lib64:$HOME/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/bin:$HOME/local/bin:$PATH"
export PS1="; "
export FZF_CTRL_T_COMMAND="git-ls.sh"
export FZF_CTRL_T_OPTS="--height '100%' --preview 'rsp {}' --preview-window=right,70%"

[ -s "$HOME/.ssh/environment" ] && . "$HOME/.ssh/environment"

command -v vim > /dev/null 2>&1 && export EDITOR="vim"
command -v nvim >/dev/null 2>&1 && export EDITOR="nvim"

# vim: set ft=sh:
