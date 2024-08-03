PKV=linux-6.6.9
URL=https://cdn.kernel.org/pub/linux/kernel/v6.x/$PKV.tar.xz
SHA256=8ebc65af0cfc891ba63dce0546583da728434db0f5f6a54d979f25ec47f548b3
DEPENDENCIES=toolchain

configure()
{
    make ARCH=$CONFIG_ARCH O=$COMPONENT_BUILD -C $COMPONENT_SRC $CONFIG_KERNEL_DEFCONFIG
    ./scripts/setconfigfragment.sh $COMPONENT_BUILD/.config $COMPONENT_RULE/config.fragment
    make ARCH=$CONFIG_ARCH O=$COMPONENT_BUILD -C $COMPONENT_SRC olddefconfig
    make ARCH=$CONFIG_ARCH O=$COMPONENT_BUILD -C $COMPONENT_SRC prepare
}

compile()
{
    make ARCH=$CONFIG_ARCH O=$COMPONENT_BUILD -C $COMPONENT_SRC -j$CONFIG_NUMCPUS
}

mkpackage()
{
    make ARCH=$CONFIG_ARCH \
        O=$COMPONENT_BUILD \
        INSTALL_PATH=$COMPONENT_PACKAGE \
        INSTALL_MOD_PATH=$COMPONENT_PACKAGE \
        -C $COMPONENT_SRC modules_install
}

