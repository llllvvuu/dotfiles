export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTFILESIZE=10000000
setopt SH_WORD_SPLIT
setopt magic_equal_subst
setopt autopushd
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_BEEP
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode

export HISTFILE="$HOME/.zsh_history"
export KEYTIMEOUT=42

# Shell config
[ -f "$HOME/dotfiles/shell/config.sh" ] && . "$HOME/dotfiles/shell/config.sh"

# Plugins
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
[ -s "$HOME/zsh-z/zsh-z.plugin.zsh" ] && \
    . "$HOME/zsh-z/zsh-z.plugin.zsh"
[ -s "$HOME/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    . "$HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -s "$HOME/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && \
    . "$HOME/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[ -s /etc/zsh_command_not_found ] && . /etc/zsh_command_not_found

[ -x "$HOME/.local/bin/mise" ] && eval "$("$HOME/.local/bin/mise" activate zsh)"
[ -f "$HOME/.fzf.zsh" ] && . "$HOME/.fzf.zsh"

# Completions
fpath+=~/.zfunc
fpath+=~/zsh-completions/src
fpath+=~/.bun
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
autoload -U +X bashcompinit && bashcompinit

[ -s "$HOME/zsh-yarn-completions/zsh-yarn-completions.plugin.zsh" ] && \
    . "$HOME/zsh-yarn-completions/zsh-yarn-completions.plugin.zsh"

[ -f "$HOME/.config/tabtab/zsh/__tabtab.zsh" ] && . "$HOME/.config/tabtab/zsh/__tabtab.zsh"

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*' menu select
