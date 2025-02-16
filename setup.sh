#!/usr/bin/env bash

currdir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
filter="$1"

echo "$currdir -- $filter"

# Determine which setup scripts to run
cd $currdir
scripts=$(find ./install -maxdepth 1 -mindepth 1 -executable -type f)

for script in $scripts; do
    if echo "$script" | grep -qv "$filter"; then
        echo "skipping $script"
        continue
    fi

    ./$script
done
