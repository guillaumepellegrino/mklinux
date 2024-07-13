DROPBEAR_PKV=dropbear-2022.83
URL=http://matt.ucc.asn.au/dropbear/releases/$DROPBEAR_PKV.tar.bz2
SHA256=bc5a121ffbc94b5171ad5ebe01be42746d50aa797c9549a4639894a16749443b
DEPENDENCIES=toolchain

configure()
{
    sed -i "s/#define DROPBEAR_SVR_PASSWORD_AUTH 1/#define DROPBEAR_SVR_PASSWORD_AUTH 0/" $COMPONENT_SRC/default_options.h
    cd $COMPONENT_BUILD
    $COMPONENT_SRC/configure --prefix=/usr --host $CONFIG_TARGET_TRIPLET --disable-zlib
}

compile()
{
    make -C $COMPONENT_BUILD -j$CONFIG_NUMCPUS all scp
}

mkpackage()
{
    DESTDIR=$COMPONENT_PACKAGE make -C $COMPONENT_BUILD install
    install -m 0755 $COMPONENT_BUILD/scp $COMPONENT_PACKAGE/usr/bin/

    # generate and install keys
    yes | ssh-keygen -f $COMPONENT_DIR/ssh_rsa_host_key -N ""
    yes | ssh-keygen -f $COMPONENT_DIR/qemu-host -N ""
    install -m 0755 -d $COMPONENT_PACKAGE/etc/dropbear
    install -m 0755 -d $COMPONENT_PACKAGE/root/.ssh
    install -m 0644 $COMPONENT_DIR/ssh_rsa_host_key $COMPONENT_PACKAGE/etc/dropbear
    install -m 0644 $COMPONENT_DIR/ssh_rsa_host_key.pub $COMPONENT_PACKAGE/etc/dropbear
    install -m 0644 -T $COMPONENT_DIR/qemu-host.pub $COMPONENT_PACKAGE/root/.ssh/authorized_keys
    cat rules/dropbear/hostconfig | envsubst > $COMPONENT_DIR/hostconfig

    # install init script
    install -m 0755 -d $COMPONENT_PACKAGE/etc/rc1.d
    install -m 0755 -T rules/dropbear/dropbear-init.sh $COMPONENT_PACKAGE/etc/rc1.d/S10dropbear
}
