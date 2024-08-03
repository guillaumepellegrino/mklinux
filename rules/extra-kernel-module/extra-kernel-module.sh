PKV=linux-6.6.9
URL=https://cdn.kernel.org/pub/linux/kernel/v6.x/$PKV.tar.xz
SHA256=8ebc65af0cfc891ba63dce0546583da728434db0f5f6a54d979f25ec47f548b3
DEPENDENCIES=linux

export COMPONENT_DIR="$PWD/component/linux"
export COMPONENT_BUILD="$COMPONENT_DIR/build"

display_help()
{
    set +x
    echo "The path to the extra kernel module 'M' is not defined."
    echo "Please use:"
    echo "M=/path/to/kernel/module make component/extra-kernel-module/compile"
    echo ""
    return 1
}

compile()
{
    if [[ -z "$M" ]]; then
        display_help
    fi
    make ARCH=$CONFIG_ARCH O=$COMPONENT_BUILD M=$M -C $COMPONENT_SRC modules -j$CONFIG_NUMCPUS
}

mkpackage()
{
    if [[ -z "$M" ]]; then
        display_help
    fi
    make ARCH=$CONFIG_ARCH \
        O=$COMPONENT_BUILD \
        M=$M \
        INSTALL_PATH=$COMPONENT_PACKAGE \
        INSTALL_MOD_PATH=$COMPONENT_PACKAGE \
        -C $COMPONENT_SRC modules_install
}

