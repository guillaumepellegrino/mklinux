
release()
{
    rsync -av --exclude='relignore' rules/sysroot/rootfs/ $RELEASEDIR
    echo $CONFIG_NAME > $RELEASEDIR/etc/hostname
    echo 127.0.0.1 localhost > $RELEASEDIR/etc/hosts
    echo 127.0.1.1 $CONFIG_NAME >> $RELEASEDIR/etc/hosts
}
