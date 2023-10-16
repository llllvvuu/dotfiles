#!/bin/sh

cd "$(dirname "$0")" || exit 1
shellcheck bash/.bash* shell/*  ./**/*.sh
shfmt "${1---diff}" bash/.bash* shell/* ./**/*.sh
