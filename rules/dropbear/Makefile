DROPBEAR_PKV=dropbear-2022.83

$(RULE)/dropbear/download:
	./scripts/download.sh dropbear http://matt.ucc.asn.au/dropbear/releases/$(DROPBEAR_PKV).tar.bz2 a75a34bcc03cacf71a2db9da3b7c94a5
	sed -i "s/#define DROPBEAR_SVR_PASSWORD_AUTH 1/#define DROPBEAR_SVR_PASSWORD_AUTH 0/" $(SRC)/dropbear/$(DROPBEAR_PKV)/default_options.h
	mkdir -p $(dir $@);	touch $@

$(RULE)/dropbear/configure: $(RULE)/dropbear/download
	@echo "Configure dropbear"
	mkdir -p $(OUTPUT)/dropbear/build
	cd $(OUTPUT)/dropbear/build && $(SRC)/dropbear/$(DROPBEAR_PKV)/configure --prefix=/usr --host $(CONFIG_TARGET_TRIPLET) --disable-zlib
	touch $@

$(RULE)/dropbear/compile: $(RULE)/dropbear/configure
	@echo "Compile dropbear"
	make -C $(OUTPUT)/dropbear/build -j$(CONFIG_NUMCPUS) all scp
	touch $@

$(RULE)/dropbear/mkpackage: $(RULE)/dropbear/compile
	# install dropbear
	DESTDIR=$(OUTPUT)/dropbear/package make -C $(OUTPUT)/dropbear/build install
	install -m 0755 $(OUTPUT)/dropbear/build/scp $(OUTPUT)/dropbear/package/usr/bin/

	# generate and install keys
	yes | ssh-keygen -f $(OUTPUT)/dropbear/ssh_rsa_host_key -N ""
	yes | ssh-keygen -f $(OUTPUT)/dropbear/qemu-host -N ""
	install -m 0755 -d $(OUTPUT)/dropbear/package/etc/dropbear
	install -m 0755 -d $(OUTPUT)/dropbear/package/root/.ssh
	install -m 0644 $(OUTPUT)/dropbear/ssh_rsa_host_key $(OUTPUT)/dropbear/package/etc/dropbear
	install -m 0644 $(OUTPUT)/dropbear/ssh_rsa_host_key.pub $(OUTPUT)/dropbear/package/etc/dropbear
	install -m 0644 -T $(OUTPUT)/dropbear/qemu-host.pub $(OUTPUT)/dropbear/package/root/.ssh/authorized_keys
	cat rules/dropbear/hostconfig | envsubst > $(OUTPUT)/dropbear/hostconfig

	# install init script
	install -m 0755 -d $(OUTPUT)/dropbear/package/etc/rc1.d
	install -m 0755 -T rules/dropbear/dropbear.sh $(OUTPUT)/dropbear/package/etc/rc1.d/S10dropbear
	touch $@
