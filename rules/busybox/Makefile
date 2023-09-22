BUSYBOX_PKV=busybox-1.35.0

$(RULE)/busybox/download:
	./scripts/download.sh busybox https://busybox.net/downloads/$(BUSYBOX_PKV).tar.bz2 585949b1dd4292b604b7d199866e9913
	mkdir -p $(dir $@);	touch $@

$(RULE)/busybox/configure: $(RULE)/busybox/download
	@echo "Configure busybox"
	mkdir -p $(OUTPUT)/busybox/build
	mkdir -p $(OUTPUT)/busybox/package
	make O=$(OUTPUT)/busybox/build -C src/busybox/$(BUSYBOX_PKV) defconfig
	@echo "CONFIG_CROSS_COMPILER_PREFIX=\"$(CONFIG_CROSS_COMPILE)\"" > $(OUTPUT)/busybox/config.fragment
	@echo "CONFIG_EXTRA_CFLAGS=\"$(CONFIG_CFLAGS) -D_XOPEN_SOURCE=700\"" >> $(OUTPUT)/busybox/config.fragment
	@echo "CONFIG_EXTRA_LDFLAGS=\"$(CONFIG_LDFLAGS)\"" >> $(OUTPUT)/busybox/config.fragment
	@echo "CONFIG_PREFIX=\"$(OUTPUT)/busybox/package\"" >> $(OUTPUT)/busybox/config.fragment
	./scripts/setconfigfragment.sh $(OUTPUT)/busybox/build/.config rules/busybox/config.fragment
	yes "" | make O=$(OUTPUT)/busybox/build -C src/busybox/$(BUSYBOX_PKV) oldconfig
	touch $@

$(RULE)/busybox/compile: $(RULE)/busybox/configure
	@echo "Compile busybox"
	make V=1 O=$(OUTPUT)/busybox/build -C src/busybox/$(BUSYBOX_PKV) -j$(CONFIG_NUMCPUS)
	touch $@

$(RULE)/busybox/mkpackage: $(RULE)/busybox/compile
	make O=$(OUTPUT)/busybox/build -C src/busybox/$(BUSYBOX_PKV) install
	touch $@

