#!/bin/bash

# modded from https://gist.github.com/joostrijneveld/59ab61faa21910c8434c

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 gpg_id output.png"
  exit 1
fi

gpg --export-secret-key "$1" | paperkey --output-type raw | base64 >paperkey.asc
split paperkey.asc -n 12 keyfrag-
rm paperkey.asc
for f in keyfrag-*; do qrencode -o "$f.png" <"$f"; done
montage -label '%f' keyfrag-*.png -geometry '1x1<' -tile 3x4 "$2"
rm keyfrag*
