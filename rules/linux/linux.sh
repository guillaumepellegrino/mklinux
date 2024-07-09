
PKV=linux-6.6.9
SRC=$COMPONENT_SRC/$PKV
URL=https://cdn.kernel.org/pub/linux/kernel/v6.x/$PKV.tar.xz
SHA256=8ebc65af0cfc891ba63dce0546583da728434db0f5f6a54d979f25ec47f548b3
DEPENDENCIES=

configure()
{
    make ARCH=$CONFIG_ARCH O=$COMPONENT_BUILD -C $SRC $CONFIG_KERNEL_DEFCONFIG
    ./scripts/setconfigfragment.sh $COMPONENT_BUILD/.config $COMPONENT_RULE/config.fragment
    make ARCH=$CONFIG_ARCH O=$COMPONENT_BUILD -C $SRC olddefconfig
}

compile()
{
    make ARCH=$CONFIG_ARCH O=$COMPONENT_BUILD -C $SRC -j$CONFIG_NUMCPUS
}

mkpackage()
{
    make ARCH=$CONFIG_ARCH \
        O=$COMPONENT_BUILD \
        INSTALL_PATH=$COMPONENT_PACKAGE \
        INSTALL_MOD_PATH=$COMPONENT_PACKAGE \
        -C $SRC modules_install
}

