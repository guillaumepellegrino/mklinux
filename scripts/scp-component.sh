#!/bin/bash
source "scripts/common-component.sh"

log "Enter"
set -x

scp -O -r -F component/dropbear/hostconfig $COMPONENT_PACKAGE/* qemu:/

set +x
log "Exit"

