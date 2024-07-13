PKV=curl-8.8.0
URL=https://github.com/curl/curl/releases/download/curl-8_8_0/$PKV.tar.gz
SHA256=77c0e1cd35ab5b45b659645a93b46d660224d0024f1185e8a95cdb27ae3d787d
DEPENDENCIES=toolchain

configure()
{
    cd $COMPONENT_BUILD
    $COMPONENT_SRC/configure --prefix=/usr --host $CONFIG_TARGET_TRIPLET --without-ssl
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all
}

mkpackage()
{
    DESTDIR=$COMPONENT_PACKAGE make -C $COMPONENT_BUILD install
}

