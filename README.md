# llllvvuu/dotfiles
Version control for my configs.
Credits to countless bloggers,
StackOverflow members, etc.

Should be pretty portable.

## Setup
### `nvim`
* set up `nvm` and `npm install -g neovim`
* set up `pyenv virtualenv` and set up `neovim3` in a venv called `neovim3`
* `pip install Pygments` in your default environment
* Install LSPs listed in `vim/.vim/plugins/cmp.lua`

The following submodules also need initial setup (`cd` in),
because I was too lazy to use Packer or anything like that:
```
vim/.vim/bundle/fzf
vim/.vim/bundle.nvim/cornelis
```

## Install
```
stow */
ln -sfn ~/.vim ~/.config/nvim
ln -sf ~/.vimrc ~/.config/nvim/init.vim
```

## Uninstall
```
stow -D */
```
