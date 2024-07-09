
PKV=busybox-1.36.1
SRC=$COMPONENT_SRC/$PKV
URL=https://busybox.net/downloads/$PKV.tar.bz2
SHA256=b8cc24c9574d809e7279c3be349795c5d5ceb6fdf19ca709f80cde50e47de314
DEPENDENCIES=

echo "package=$COMPONENT_PACKAGE"

configure()
{
    make O=$COMPONENT_BUILD -C $COMPONENT_SRC/$PKV defconfig
    echo "CONFIG_CROSS_COMPILER_PREFIX=\"$CONFIG_CROSS_COMPILE\"" > $COMPONENT_BUILD/config.fragment
    echo "CONFIG_EXTRA_CFLAGS=\"$CFLAGS -D_XOPEN_SOURCE=700\"" >> $COMPONENT_BUILD/config.fragment
    echo "CONFIG_EXTRA_LDFLAGS=\"$LDFLAGS\"" >> $COMPONENT_BUILD/config.fragment
    echo "CONFIG_PREFIX=\"$COMPONENT_PACKAGE\"" >> $COMPONENT_BUILD/config.fragment
    $SCRIPTDIR/setconfigfragment.sh $COMPONENT_BUILD/.config rules/busybox/config.fragment
    sed -i "s/CONFIG_TC.*/# CONFIG_TC is not set/" $COMPONENT_BUILD/.config
    sed -i "s/CONFIG_FEATURE_TC_INGRESS.*/# CONFIG_FEATURE_TC_INGRESS is not set/" $COMPONENT_BUILD/.config
    yes "" | make O=$COMPONENT_BUILD -C $SRC oldconfig

    # it looks like 'make oldconfig' override the prefix value ??
    sed -i "s|CONFIG_PREFIX=.*|CONFIG_PREFIX=\"$COMPONENT_PACKAGE\"|" $COMPONENT_BUILD/.config

    echo "s|CONFIG_PREFIX=.*|CONFIG_PREFIX=\"$COMPONENT_PACKAGE\"|"
}

compile()
{
    make V=1 O=$COMPONENT_BUILD -C $SRC -j$CONFIG_NUMCPUS
}

mkpackage()
{
    make O=$COMPONENT_BUILD -C $SRC install
}
