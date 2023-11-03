#!/bin/sh

cd "$(dirname "$0")" || exit
sops --encrypt --pgp 69E39F76AF5341EAC8735FD7D2E4D22B50D8E5E5 en.utf-8.add >en.utf-8.add.enc
sops --encrypt --pgp 69E39F76AF5341EAC8735FD7D2E4D22B50D8E5E5 en.utf-8.add.spl >en.utf-8.add.spl.enc
