URL=https://github.com/guillaumepellegrino/memtrace/archive/refs/tags/v1.2.3.tar.gz
SHA256=64bce7d6594552b1a4f481d795f0c13863700f39a7586122fafc27de9dac9a29
DEPENDENCIES=toolchain

compile()
{
    make O=$COMPONENT_BUILD -C $COMPONENT_SRC -f Makefile.target -j$CONFIG_NUMCPUS
}

mkpackage()
{
    make O=$COMPONENT_BUILD DESTDIR=$COMPONENT_PACKAGE -C $COMPONENT_SRC -f Makefile.target install
}
