#!/bin/bash
source "scripts/common-component.sh"

if [[ $(type -t mkpackage) == function ]]; then
    log "Enter"
    set -x
    mkdir -p $COMPONENT_DIR/package
    mkpackage
    set +x
    log "Exit"
else
    log "nothing to do"
fi

touch "$COMPONENT_DIR/mkpackage"
