#!/usr/bin/env bash

# Grab the directory this script is running from
currdir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Define some defaults for our setup args
filter=""
dry_run="0"

# Parse our command line args
while [[ $# > 0 ]]; do
    if [[ $1 == "--dry" ]]; then
        dry="1"
    else
        filter="$1"
    fi
    shift
done

# Grab all of our install scripts
cd $currdir
scripts=$(find ./install -maxdepth 1 -mindepth 1 -executable -type f)

# Run our install scripts unless they don't match the provided filter
for script in $scripts; do
    if echo "$script" | grep -qv "$filter"; then
        echo "skipping $script"
        continue
    fi

    if [[ $dry == "1" ]]; then
        echo "[DRY] Installing $script"
        continue
    fi

    ./$script
done
