
$(RULE)/arm-toolchain/download:
	mkdir -p $(dir $@);	touch $@

$(RULE)/arm-toolchain/configure: $(RULE)/arm-toolchain/download
	touch $@

$(RULE)/arm-toolchain/compile: $(RULE)/arm-toolchain/configure
	touch $@

$(RULE)/arm-toolchain/mkpackage: $(RULE)/arm-toolchain/compile
	mkdir -p $(RULE)/arm-toolchain/package/lib
	rsync -av /usr/arm-linux-gnueabi/lib/ $(RULE)/arm-toolchain/package/lib
	touch $@

