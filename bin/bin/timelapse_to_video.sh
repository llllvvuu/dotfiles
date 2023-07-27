#!/bin/sh

ffmpeg -framerate 4 -pattern_type glob -i '*.png' -c:v libx264 -pix_fmt yuv420p -crf 28 -vf "scale=iw/2:ih/2" "$1"
