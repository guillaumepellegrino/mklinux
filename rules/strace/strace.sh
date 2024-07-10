
PKV=strace-6.9
SRC=$COMPONENT_SRC/$PKV
URL=https://github.com/strace/strace/releases/download/v6.9/strace-6.9.tar.xz
SHA256=da189e990a82e3ca3a5a4631012f7ecfd489dab459854d82d8caf6a865c1356a
DEPENDENCIES=

configure()
{
    cd $COMPONENT_BUILD
    $SRC/configure --enable-mpers=no --prefix=/usr --host $CONFIG_TARGET_TRIPLET
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS
}

mkpackage()
{
    make DESTDIR=$COMPONENT_PACKAGE -C $COMPONENT_BUILD install
}

