#!/bin/bash

SRC="$1"
DST="$2"

cd $SRC

echo "rsync -a . $DST"
rsync -av \
    --exclude='*.h' \
    --exclude='*.o' \
    --exclude='*.a' \
    --exclude='*.a.*' \
    --exclude='man' \
    --exclude='doc' \
    . "$DST"

#for exe in $(find -type f -executable); do
#    echo "$STRIP --strip-unneeded $DST/$exe"
#    "$STRIP" --strip-unneeded "$DST/$exe"
#done

exit 0
