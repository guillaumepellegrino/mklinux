LINUX_PKV=linux-6.0.11
DEPENDENCIES=libmpc-dev

$(RULE)/linux/download:
	./scripts/download.sh linux https://cdn.kernel.org/pub/linux/kernel/v6.x/$(LINUX_PKV).tar.xz 7a47796e842b77519613abbca6037c91
	mkdir -p $(dir $@);	touch $@

$(RULE)/linux/install_headers: $(RULE)/linux/download
	make ARCH=$(CONFIG_ARCH) \
		O=$(OUTPUT)/linux/build \
		INSTALL_HDR_PATH=$(OUTPUT)/toolchain/$(CONFIG_TARGET_TRIPLET)/sysroot/usr \
		-C src/linux/$(LINUX_PKV) headers_install -j$(CONFIG_NUMCPUS)
	make ARCH=$(CONFIG_ARCH) O=$(OUTPUT)/linux/build -C src/linux/$(LINUX_PKV) mrproper
	touch $@

$(RULE)/linux/configure: $(RULE)/linux/download
	mkdir -p $(OUTPUT)/linux/build
	make ARCH=$(CONFIG_ARCH) O=$(OUTPUT)/linux/build -C src/linux/$(LINUX_PKV) $(CONFIG_KERNEL_DEFCONFIG)
	./scripts/setconfigfragment.sh $(OUTPUT)/linux/build/.config rules/linux/config.fragment
	make ARCH=$(CONFIG_ARCH) O=$(OUTPUT)/linux/build -C src/linux/$(LINUX_PKV) olddefconfig
	touch $@

$(RULE)/linux/compile: $(RULE)/linux/configure
	make ARCH=$(CONFIG_ARCH) O=$(OUTPUT)/linux/build -C src/linux/$(LINUX_PKV) -j$(CONFIG_NUMCPUS)
	touch $@

$(RULE)/linux/mkpackage: $(RULE)/linux/compile
	make ARCH=$(CONFIG_ARCH) O=$(OUTPUT)/linux/build INSTALL_PATH=$(OUTPUT)/linux/package INSTALL_MOD_PATH=$(OUTPUT)/linux/package -C src/linux/$(LINUX_PKV) modules_install
	touch $@

$(RULE)/linux/help: $(RULE)/linux/download
	make ARCH=$(CONFIG_ARCH) O=$(OUTPUT)/linux/build -C src/linux/$(LINUX_PKV) help

$(RULE)/linux/menuconfig: $(RULE)/linux/download
	make ARCH=$(CONFIG_ARCH) O=$(OUTPUT)/linux/build -C src/linux/$(LINUX_PKV) menuconfig
