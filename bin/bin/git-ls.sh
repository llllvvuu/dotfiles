#!/bin/sh

git ls-files | awk -F/ '{
    print $0
    path=""
    for (i=1; i<=NF; i++) {
        path = (path == "") ? $i : path"/"$i;
        print path
    }
}' | sort -u
