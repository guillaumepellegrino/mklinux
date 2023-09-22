#!/bin/bash

SRC="$1"
DST="$2"

rsync -a "$SRC" "$DST"
