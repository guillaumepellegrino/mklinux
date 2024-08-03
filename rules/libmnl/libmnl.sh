URL=https://www.netfilter.org/projects/libmnl/files/libmnl-1.0.5.tar.bz2
SHA256=274b9b919ef3152bfb3da3a13c950dd60d6e2bcd54230ffeca298d03b40d0525
DEPENDENCIES="toolchain"

configure()
{
    cd $COMPONENT_BUILD
    $COMPONENT_SRC/configure --prefix=/usr --host $CONFIG_TARGET_TRIPLET --with-doxygen
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all
}

mkpackage()
{
    DESTDIR=$COMPONENT_PACKAGE make -C $COMPONENT_BUILD install || true # ignore error
    mkdir -p $COMPONENT_PACKAGE/usr/lib/pkgconfig/
    cp $COMPONENT_BUILD/libmnl.pc $COMPONENT_PACKAGE/usr/lib/pkgconfig/
}

