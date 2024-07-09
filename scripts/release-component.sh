#!/bin/bash
source "scripts/common-component.sh"

if [[ $(type -t release) == function ]]; then
    log "Enter"
    set -x
    mkdir -p release/
    release
    set +x
    log "Exit"
elif [[ $(type -t mkpackage) == function ]]; then
    log "Enter"
    set -x
    mkdir -p release/
    cd "$COMPONENT_PACKAGE"
    rsync -av \
        --exclude='*.h' \
        --exclude='*.o' \
        --exclude='*.a' \
        --exclude='*.a.*' \
        --exclude='man' \
        --exclude='doc' \
        . "$RELEASEDIR"
    set +x
    log "Exit"
fi

touch "$COMPONENT_DIR/release"
