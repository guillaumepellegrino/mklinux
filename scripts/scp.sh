#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: $0 /path/to/src qemu:/path/to/dst"
    exit
fi
scp -O -r -F component/dropbear/hostconfig "$@"

