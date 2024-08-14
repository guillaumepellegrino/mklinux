#!/bin/bash
source "scripts/common-component.sh"

component_chksum()
{
    sha256sum "$COMPONENT_DOWNLOAD/$DLNAME" 2> /dev/null | cut -f 1 -d ' '
}

component_download()
{
    echo "$PROTOCOL download $DLNAME"
    mkdir -p "$COMPONENT_DOWNLOAD"

    case "$PROTOCOL" in
        http|https)
            curl -L "$URL" --output "$COMPONENT_DOWNLOAD/$DLNAME" || error "curl error"
            ;;
        git)
            #git clone "$URL" "$COMPONENT_DOWNLOAD/$DLNAME" || error "clone git repository"
            ;;
        *)
    esac
    if [[ "$SHA256" != "$(component_chksum)" ]]; then
        error "Expected sha256 for $COMPONENT_DOWNLOAD/$DLNAME is $SHA256 and not $(component_chksum)"
    fi
}

component_extract()
{
    echo "Extract $DLNAME"
    mkdir -p "$COMPONENT_SRC"
    case "$COMPONENT_DOWNLOAD/$DLNAME" in
        *.tar.bz2) tar --strip-components=1 -xf "$COMPONENT_DOWNLOAD/$DLNAME" -C "$COMPONENT_SRC" || error "extract";;
        *.tar.gz)  tar --strip-components=1 -xzf "$COMPONENT_DOWNLOAD/$DLNAME" -C "$COMPONENT_SRC" || error "extract";;
        *.tar.xz)  tar --strip-components=1 -xf "$COMPONENT_DOWNLOAD/$DLNAME" -C "$COMPONENT_SRC" || error "extract";;
        *)         error "$DLNAME: Unknown file extension";;
    esac
}

mkdir -p "$COMPONENT_DIR"
if [ -z "$URL" ]; then
    touch "$COMPONENT_DIR/download"
    exit 0
fi

log "Enter"

log "URL is $URL"
PROTOCOL=$(echo "$URL" | sed "s|://.*||")
DLNAME=$(basename "$URL")

if [[ -d "$URL" ]]; then
    echo "ln -sfT $URL $COMPONENT_SRC"
    ln -sfT "$URL" "$COMPONENT_SRC"
else
    log "SHA256 is $SHA256"
    if [[ "$SHA256" != "$(component_chksum)" ]]; then
        component_download
    fi
    component_extract
fi

touch "$COMPONENT_DIR/download"
log "Exit"
