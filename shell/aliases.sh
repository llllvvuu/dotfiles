alias l='ls -lF'
alias la='ls -laF'
alias rm='rm -i'

command -v git >/dev/null 2>&1 && alias g='git'
command -v vim >/dev/null 2>&1 && alias vi='vim'
command -v nvim >/dev/null 2>&1 && alias vi='nvim' && alias vim='nvim'
command -v emacs >/dev/null 2>&1 && alias ed='emacs --daemon' && alias ec="emacsclient -nw" && alias ek="emacsclient -e '(kill-emacs)'" && alias er="ek && ed"

# vim: set ft=sh:
