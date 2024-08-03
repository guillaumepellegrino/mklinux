URL=https://www.netfilter.org/projects/iptables/files/iptables-1.8.10.tar.xz
SHA256=5cc255c189356e317d070755ce9371eb63a1b783c34498fb8c30264f3cc59c9c
DEPENDENCIES="toolchain libnfnetlink libnetfilter_conntrack"

configure()
{
    cd $COMPONENT_BUILD
    $COMPONENT_SRC/configure --prefix=/usr --host $CONFIG_TARGET_TRIPLET --disable-nftables
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all
}

mkpackage()
{
    DESTDIR=$COMPONENT_PACKAGE make -C $COMPONENT_BUILD install
}

