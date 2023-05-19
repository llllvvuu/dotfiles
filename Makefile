.PHONY: all install clean

.ONESHELL:
SHELL = /bin/bash
setup-ubuntu:
	if python -mplatform | grep -qi Ubuntu; then
		echo "Setting up for Ubuntu via apt-get..."
		sudo add-apt-repository ppa:neovim-ppa/unstable
		sudo add-apt-repository ppa:ethereum/ethereum
		sudo add-apt-repository ppa:ethereum/ethereum-dev
		sudo apt update
		sudo apt install software-properties-common python-dev \
			python3-pip cmake python-pygments \
			neovim zsh nodejs npm luarocks stow libffi-dev \
			build-essential python-setuptools python3-smbus \
			libncursesw5-dev libgdbm-dev libc6-dev \
			zlib1g-dev libsqlite3-dev tk-dev \
			libssl-dev openssl ripgrep solc\
		sudo npm install --global yarn
		sudo yarn global add neovim typescript pyright
		sudo luarocks install luacheck
	fi

.ONESHELL:
SHELL = /bin/bash
setup-osx:
	if python -mplatform | grep -qi Darwin; then
		echo "Setting up for OS X via brew..."
		brew update
		brew install python python3 neovim ripgrep cmake stow go gnupg tmux node lua luarocks yarn
		pip install Pygments
		yarn global add neovim typescript
		luarocks install luacheck
	fi

setup: setup-osx setup-ubuntu
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	cd ~/.pyenv && src/configure && make -C src
	git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
	pyenv install 3.10.2
	pyenv virtualenv 3.10.2 neovim3

.fzf: .git/modules/fzf/HEAD
	printf 'y\ny\nn\n' | ./vim/.vim/bundle/fzf/install
	touch .fzf

.fzf-clean:
	echo 'y' | ./vim/.vim/bundle/fzf/uninstall
	rm .fzf

all: .fzf

clean: .fzf-clean

install: all
	stow */
	ln -sfn ~/.vim ~/.config/nvim
	ln -sf ~/.vimrc ~/.config/nvim/init.vim

uninstall:
	stow -D */
