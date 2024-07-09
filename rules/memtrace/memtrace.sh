
PKV=1.1.0
SRC=$COMPONENT_SRC/memtrace-$PKV
URL=https://github.com/guillaumepellegrino/memtrace/archive/refs/tags/v$PKV.tar.gz
SHA256=7128cb82c5ff1e91686cd6aa5fef89e65b06480c2d18782769d5ec12de0e011d
DEPENDENCIES=

compile()
{
    make O=$COMPONENT_BUILD -C $SRC -f Makefile.target -j$CONFIG_NUMCPUS
}

mkpackage()
{
    make O=$COMPONENT_BUILD DESTDIR=$COMPONENT_PACKAGE -C $SRC -f Makefile.target install
}
