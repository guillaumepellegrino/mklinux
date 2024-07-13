PKV=gdb-13.2
URL=https://ftp.gnu.org/gnu/gdb/$PKV.tar.xz
SHA256=fd5bebb7be1833abdb6e023c2f498a354498281df9d05523d8915babeb893f0a
DEPENDENCIES=toolchain

configure()
{
    cd $COMPONENT_BUILD
    $COMPONENT_SRC/configure --prefix=/usr --host $CONFIG_TARGET_TRIPLET --disable-libstdcxx
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all
}

mkpackage()
{
    DESTDIR=$COMPONENT_PACKAGE make -C $COMPONENT_BUILD install
}

