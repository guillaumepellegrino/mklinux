URL=https://github.com/iproute2/iproute2/archive/refs/tags/v6.10.0.tar.gz
SHA256=060ee42dfcdf8b9daf9f986eee26d16ac5bdf39c8784702957b13bebec538541
DEPENDENCIES=libmnl

configure()
{
    cp -rf $COMPONENT_SRC/* $COMPONENT_BUILD/
    cp -f $COMPONENT_RULE/config.mk $COMPONENT_BUILD/
}

compile()
{
    make CC=$CC AR=$AR LD=$LD -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all
}

mkpackage()
{
    make CC=$CC AR=$AR LD=$LD DESTDIR=$COMPONENT_PACKAGE -C $COMPONENT_BUILD install
}

