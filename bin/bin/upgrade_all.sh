#!/bin/sh

has() {
  command -v "$1" >/dev/null 2>&1
}

has brew && brew update && brew upgrade
has apt && sudo apt update && sudo apt full-upgrade --autoremove --purge -y
has cargo-install-update && cargo install-update -a
has go-global-update && go-global-update
has npm && npm -g update
has pip-review && pip-review --auto
has ghcup && ghcup upgrade && ghcup list
has rtx && rtx outdated
