#!/bin/bash

NAME="$1"
URI="$2"
MD5SUM="$3"
PROTOCOL=$(echo "$URI" | sed "s|://.*||")
DLNAME=$(basename "$URI")

error()
{
    echo "Error $@"
    exit 1
}

cmdlog()
{
    echo "$@"
    "$@"
}

component_chksum()
{
    md5sum "download/$DLNAME" 2> /dev/null | cut -f 1 -d ' '
}

component_download()
{
    echo "$PROTOCOL download $DLNAME"
    mkdir -p "download/"

    case "$PROTOCOL" in
        http|https)
            cmdlog curl -L "$URI" --output "download/$DLNAME" || error "download"
            ;;
        git)
            #git clone "$URI" "download/$DLNAME" || error "clone git repository"
            ;;
        *)
    esac
    if [[ "$MD5SUM" != "$(component_chksum)" ]]; then
        error "Expected md5sum for download/$DLNAME is $MD5SUM and not $(component_chksum)"
    fi
}

component_extract()
{
    echo "Extract $DLNAME"
    mkdir -p "src/$NAME"
    case "download/$DLNAME" in
        *.tar.bz2) tar -xf "download/$DLNAME" -C "src/$NAME" || error "extract";;
        *.tar.gz)  tar -xzf "download/$DLNAME" -C "src/$NAME" || error "extract";;
        *.tar.xz)  tar -xf "download/$DLNAME" -C "src/$NAME" || error "extract";;
        *)         error "$NAME: Unknown file extension";;
    esac
}

local_component_copy()
{
    echo "Copy local component to src/$NAME from $URI"
    rsync -a "$URI/" "src/$NAME"
}

echo "URI=$URI"
if [[ -d "$URI" ]]; then
    local_component_copy
    exit
fi

if [[ "$MD5SUM" != "$(component_chksum)" ]]; then
    component_download
fi
component_extract
