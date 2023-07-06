# Options
setopt SH_WORD_SPLIT
setopt magic_equal_subst
setopt autopushd
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode

# Sources
[ -s $HOME/.zsh_prompt ] && source $HOME/.zsh_prompt
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
[ -s $HOME/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    . $HOME/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -s /etc/zsh_command_not_found ] && . /etc/zsh_command_not_found
[ -f $HOME/.fzf.zsh ] && . $HOME/.fzf.zsh

[ -f $HOME/.posixrc ] && . $HOME/.posixrc

fpath+=~/.zfunc
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select
[ -s "/Users/llwu/.bun/_bun" ] && source "/Users/llwu/.bun/_bun"
[ -s $HOME/zsh-yarn-completions/zsh-yarn-completions.plugin.zsh ] && \
    . $HOME/zsh-yarn-completions/zsh-yarn-completions.plugin.zsh
[ -s $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    . $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
