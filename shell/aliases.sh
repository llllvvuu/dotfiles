#!/bin/sh

alias rm='rm -i'

command -v git >/dev/null 2>&1 && alias g='git'
if command -v eza >/dev/null 2>&1; then
  alias l='eza -lF'
  alias la='eza -laF'
else
  alias l='ls -F'
  alias la='ls -laF'
fi
command -v vim >/dev/null 2>&1 && alias vi='vim'
command -v nvim >/dev/null 2>&1 && {
  alias vi='nvim'
  alias vim='nvim'
  command -v dvim >/dev/null 2>&1 || {
    alias dvim="VIMRUNTIME=./runtime ./build/bin/nvim --luamod-dev"
  }
}
command -v emacsclient >/dev/null 2>&1 && {
  alias emacs='emacsclient -ta "" -e "(with-current-buffer \"*scratch*\" (setq default-directory \"$(pwd)/\"))" >/dev/null; emacsclient -ta ""'
}

# vim: set ft=sh:
