# llllvvuu/dotfiles
Version control for my configs.
Credits to countless bloggers,
StackOverflow members, etc.

Should be pretty portable.

## Setup (Work in Progress)
I haven't set up any provisioning (e.g. Vagrant) yet,
though the following may work:
```
$ make setup
```

## pyenv for Neovim
```
pyenv install 3.10.0
pyenv virtualenv 3.10.0 neovim3
pyenv activate neovim3
pip install neovim pynvim
```

## Other Neovim stuff
For Rust completion, install the `rust-analyzer` binary.

## Install/Uninstall
I use
[GNU Stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
for management.

To install all configs at once:
```
$ make install
```
To uninstall all configs at once:
```
$ make uninstall
```
To clean out build artifacts:
```
$ make clean
```
To individually install a config for `$PACKAGENAME`:
```
stow $PACKAGENAME
```
To individually uninstall a config for `$PACKAGENAME`:
```
stow -D $PACKAGENAME
```
