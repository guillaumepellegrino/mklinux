
$(RULE)/x86_64-toolchain/download:
	mkdir -p $(dir $@);	touch $@

$(RULE)/x86_64-toolchain/configure: $(RULE)/x86_64-toolchain/download
	touch $@

$(RULE)/x86_64-toolchain/compile: $(RULE)/x86_64-toolchain/configure
	touch $@

$(RULE)/x86_64-toolchain/mkpackage: $(RULE)/x86_64-toolchain/compile
	mkdir -p $(OUTPUT)/x86_64-toolchain/package/{lib/x86_64-linux-gnu,lib64}
	cd /usr/lib/x86_64-linux-gnu/ && rsync -av ld-* libc.* libdl* libselinux.so* libseccomp.so* libm.* librt* libpthread* libresolv* libcrypt* $(OUTPUT)/x86_64-toolchain/package/lib/x86_64-linux-gnu/
	cd /lib64/ && rsync -av ld-* $(OUTPUT)/x86_64-toolchain/package/lib64/
	touch $@

