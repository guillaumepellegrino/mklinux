
PKV=pcre2-10.44
SRC="$COMPONENT_SRC/$PKV"
URL=https://github.com/PCRE2Project/pcre2/releases/download/$PKV/$PKV.tar.gz
SHA256=86b9cb0aa3bcb7994faa88018292bc704cdbb708e785f7c74352ff6ea7d3175b
DEPENDENCIES=

configure()
{
    cd $COMPONENT_BUILD
    $SRC/configure --prefix=/usr --host $CONFIG_TARGET_TRIPLET
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all
}

mkpackage()
{
    DESTDIR=$COMPONENT_PACKAGE make -C $COMPONENT_BUILD install
}

