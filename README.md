## Getting started
- Install [`rustup`](https://github.com/rust-lang/rustup)
- Install [`rtx`](https://github.com/jdx/rtx) for managing runtimes (Node, Python, Go, Java, Ruby, etc)

## Install configs
```sh
git submodule update --init --recursive
mkdir -p ~/.config
stow */
```

## Uninstall configs
```sh
stow -D */
```
