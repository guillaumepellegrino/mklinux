URL=https://github.com/openssl/openssl/releases/download/openssl-3.3.1/openssl-3.3.1.tar.gz
SHA256=777cd596284c883375a2a7a11bf5d2786fc5413255efab20c50d6ffe6d020b7e
DEPENDENCIES=toolchain

# openssl does not like to have both CROSS_COMPILE and CC defined at the same time
unset CC CXX LD AR STRIP

configure()
{
    cd $COMPONENT_BUILD
    $COMPONENT_SRC/Configure --prefix=$COMPONENT_PACKAGE/usr \
        --openssldir=$COMPONENT_PACKAGE/usr \
        $CONFIG_OPENSSL_TRIPLET '-Wl,-rpath,$(LIBRPATH)'
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all
}

mkpackage()
{
    make -C $COMPONENT_BUILD install
}

