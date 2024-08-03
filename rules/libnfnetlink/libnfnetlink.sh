URL=https://www.netfilter.org/projects/libnfnetlink/files/libnfnetlink-1.0.2.tar.bz2
SHA256=b064c7c3d426efb4786e60a8e6859b82ee2f2c5e49ffeea640cfe4fe33cbc376
DEPENDENCIES=toolchain

configure()
{
    cd $COMPONENT_BUILD
    $COMPONENT_SRC/configure --prefix=/usr --host $CONFIG_TARGET_TRIPLET
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all
}

mkpackage()
{
    DESTDIR=$COMPONENT_PACKAGE make -C $COMPONENT_BUILD install
}

