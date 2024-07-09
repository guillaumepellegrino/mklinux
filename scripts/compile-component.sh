#!/bin/bash
source "scripts/common-component.sh"

if [[ $(type -t compile) == function ]]; then
    log "Enter"
    set -x
    compile
    set +x
    log "Exit"
else
    log "nothing to do"
fi

touch "$COMPONENT_DIR/compile"
