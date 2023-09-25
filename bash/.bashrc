[ -x $HOME/local/bin/rtx ] && eval "$($HOME/local/bin/rtx activate bash)"
[ -f $HOME/.fzf.bash ] && . $HOME/.fzf.bash

shopt -s autocd

[ -s $HOME/git-completion.bash ] && . $HOME/git-completion.bash
[ -s /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -s /usr/share/bash-completion/completions/git ] && \
    . /usr/share/bash-completion/completions/git

if command -v brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

command -v __git_complete >/dev/null 2>&1 && __git_complete g __git_main

bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

[ -s $HOME/dotfiles/shell/config.sh ] && . $HOME/dotfiles/shell/config.sh
