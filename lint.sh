#!/bin/sh

cd "$(dirname "$0")" || exit 1
shellcheck bash/.bash* shell/* 
