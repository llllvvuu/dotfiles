#!/bin/sh

alias l='ls -lF'
alias la='ls -laF'
alias rm='rm -i'

command -v git >/dev/null 2>&1 && alias g='git'
command -v vim >/dev/null 2>&1 && alias vi='vim'
command -v nvim >/dev/null 2>&1 && alias vi='nvim' && alias vim='nvim'
command -v emacsclient >/dev/null 2>&1 && alias emacs='emacsclient -ta "" -e "(with-current-buffer \"*scratch*\" (setq default-directory \"$(pwd)/\"))" >/dev/null; emacsclient -ta ""'

# vim: set ft=sh:
