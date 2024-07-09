#!/bin/bash
source "scripts/common-component.sh"

mkdir -p "$COMPONENT_BUILD"
if [[ $(type -t configure) == function ]]; then
    log "Enter"
    set -x
    configure
    set +x
    log "Exit"
else
    log "nothing to do"
fi

touch "$COMPONENT_DIR/configure"