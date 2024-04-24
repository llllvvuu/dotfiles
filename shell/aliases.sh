#!/bin/sh

alias rm='rm -i'

command -v git >/dev/null 2>&1 && alias g='git'
if command -v eza >/dev/null 2>&1; then
  alias l='eza -lF'
  alias la='eza -laF'
else
  alias l='ls -F --color=auto'
  alias la='ls -laF --color=auto'
fi
command -v nvim >/dev/null 2>&1 && {
  alias vim='nvim'
}

# vim: set ft=sh:
