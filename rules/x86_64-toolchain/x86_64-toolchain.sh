PKV=x86-64--glibc--bleeding-edge-2024.02-1
URL=https://toolchains.bootlin.com/downloads/releases/toolchains/x86-64/tarballs/$PKV.tar.bz2
SHA256=7aac949737ebfb3f4bccc6a75af79d50cf1fadd9ffbdf21e26c1508dff67f23d
DEPENDENCIES=

release()
{
    #mkdir -p $COMPONENT_PACKAGE/{lib/x86_64-linux-gnu,lib64}
    #cd /usr/lib/x86_64-linux-gnu/ && rsync -av ld-* libc.* libdl* libselinux.so* libseccomp.so* libm.* librt* libpthread* libresolv* libcrypt* $COMPONENT_PACKAGE/lib/x86_64-linux-gnu/
    #cd /lib64/ && rsync -av ld-* $COMPONENT_PACKAGE/lib64/
    cd $COMPONENT_SRC/x86_64-buildroot-linux-gnu/sysroot
    rsync -av . $RELEASEDIR
    ln -sfT . $RELEASEDIR/lib/x86_64-linux-gnu
    ln -sfT . $RELEASEDIR/usr/lib/x86_64-linux-gnu
    rm -f $RELEASEDIR/etc/profile
}
