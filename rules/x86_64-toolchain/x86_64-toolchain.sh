
mkpackage()
{
    mkdir -p $COMPONENT_PACKAGE/{lib/x86_64-linux-gnu,lib64}
    cd /usr/lib/x86_64-linux-gnu/ && rsync -av ld-* libc.* libdl* libselinux.so* libseccomp.so* libm.* librt* libpthread* libresolv* libcrypt* $COMPONENT_PACKAGE/lib/x86_64-linux-gnu/
    cd /lib64/ && rsync -av ld-* $COMPONENT_PACKAGE/lib64/
}
