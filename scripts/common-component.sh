#!/bin/bash

set -e

ME="$(basename $0)"
ME=${ME%-*}

export COMPONENT="$1"
export COMPONENT_RULE="$PWD/rules/$COMPONENT"
export COMPONENT_DOWNLOAD="$PWD/download/$COMPONENT"
export COMPONENT_SRC="$PWD/src/$COMPONENT"
export COMPONENT_DIR="$PWD/component/$COMPONENT"
export COMPONENT_BUILD="$COMPONENT_DIR/build"
export COMPONENT_PACKAGE="$COMPONENT_DIR/package"

log()
{
    echo "[$COMPONENT][$ME] $@"
}

error()
{
    log "$@"
    exit 1
}

source "$RULESDIR/${COMPONENT}/${COMPONENT}.sh"
