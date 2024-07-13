#!/bin/bash

# Exit on any error with the exception of
# - command failure in a pipeline
# - when evaluating while, until, if, elif, !
# - command running in a subshell
set -e

help()
{
    echo "Usage: ./configure.sh [configname]"
}

main()
{
    local configname="$1"
    if [ -z "$configname" ]; then
        help
        exit 1
    fi
    local output="output/$configname"
    mkdir -p "$output"{/,/staging,/release,/component} src download
    cat "config/$configname/config.mk" defaults.mk > "$output/config.mk"
    ln -sfT "../../config/$configname" "$output/config"
    ln -sfT "../../scripts/Makefile.build" "$output/Makefile"
    ln -sfT "../../download" "$output/download"
    ln -sfT "../../rules" "$output/rules"
    ln -sfT "../../scripts" "$output/scripts"
    ln -sfT "../../src" "$output/src"

    local rules=rules/*
    local components=$(echo $rules | sed "s|rules/||g")
    local makefile_deps="$output/dependencies.mk"

    echo "###" > "$makefile_deps"
    echo "# build dependencies " >> "$makefile_deps"
    echo "###" >> "$makefile_deps"
    echo "" >> "$makefile_deps"
    for component in $components; do
        ./scripts/makedeps.sh "$component" >> "$makefile_deps"
    done

    echo "Build configured with success"
    echo "You can now, start the build with:"
    echo "cd $output"
    echo "make all"
}

main "$@"
