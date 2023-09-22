
$(RULE)/sysroot/download:
	mkdir -p $(RULE)/sysroot
	mkdir -p $(dir $@);	touch $@

$(RULE)/sysroot/configure: $(RULE)/sysroot/download
	touch "$@"

$(RULE)/sysroot/compile: $(RULE)/sysroot/configure
	touch "$@"

$(RULE)/sysroot/install: $(RULE)/sysroot/compile
	touch "$@"

$(RULE)/sysroot/release: $(RULE)/sysroot/install
	@echo "Install sysroot ($(CONFIG_SYSROOT_LIB)) to $(ROOTFS)"
	rsync -av --exclude='relignore' rules/sysroot/rootfs/ $(ROOTFS)
	echo $(CONFIG_NAME) > $(ROOTFS)/etc/hostname
	echo 127.0.0.1 localhost > $(ROOTFS)/etc/hosts
	echo 127.0.1.1 $(CONFIG_NAME) >> $(ROOTFS)/etc/hosts
	touch "$@"

