## Get software
1. Install distro packages from `.pkg/distro/$YOUR_DISTRO.txt` using `sed`/`awk`/`xargs`/etc
2. Install [`rustup`](https://github.com/rust-lang/rustup), which gives you `cargo`
3. [`cargo install rtx`](https://github.com/jdx/rtx)
4. `rtx install node python go`
5. Install [`ghcup`](https://www.haskell.org/ghcup/) (for Haskell)
6. Install runtime packages from `.pkg/runtime/*.txt`
7. Build and install Neovim nightly ([README](https://github.com/neovim/neovim/wiki/Building-Neovim))

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
