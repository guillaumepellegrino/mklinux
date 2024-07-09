#!/bin/bash
source "scripts/common-component.sh"

if [[ $(type -t install) == function ]]; then
    log "Enter"
    set -x
    mkdir -p staging/
    install
    set +x
    log "Exit"
elif [[ $(type -t mkpackage) == function ]]; then
    log "Enter"
    set -x
    mkdir -p staging/
    rsync -a "$COMPONENT_PACKAGE/" "$STAGINGDIR"
    set +x
    log "Exit"
else
    log "Nothing to do"
fi

touch "$COMPONENT_DIR/install"
