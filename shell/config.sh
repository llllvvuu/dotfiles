#!/bin/sh

[ -s "$HOME/.shellrc" ] && . "$HOME/.shellrc"

. "$HOME/dotfiles/shell/env.sh"
. "$HOME/dotfiles/shell/aliases.sh"

# De-dupe $PATH
PATH="$(printf %s "$PATH" |
  awk -vRS=: -vORS= '!a[$0]++ {if (NR>1) printf(":"); printf("%s", $0) }')"
export PATH
