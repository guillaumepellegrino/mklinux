OPENSSL_PKV=openssl-3.0.7

$(RULE)/openssl/download:
	./scripts/download.sh openssl https://www.openssl.org/source/$(OPENSSL_PKV).tar.gz 545478ce41b96bf3beacb4dc58b36c77
	mkdir -p $(dir $@);	touch $@

$(RULE)/openssl/configure: $(RULE)/openssl/download
	@echo "Configure openssl"
	mkdir -p $(OUTPUT)/openssl/build
		cd $(OUTPUT)/openssl/build && CROSS_COMPILE=$(CONFIG_CROSS_COMPILE) $(SRC)/openssl/$(OPENSSL_PKV)/config $(CONFIG_OPENSSL_TRIPLET) --prefix=$(OUTPUT)/openssl/package/usr
	touch $@

$(RULE)/openssl/compile: $(RULE)/openssl/configure
	@echo "Compile openssl"
	make -C $(OUTPUT)/openssl/build -j$(CONFIG_NUMCPUS)
	touch $@

$(RULE)/openssl/mkpackage: $(RULE)/openssl/compile
	make -C $(OUTPUT)/openssl/build  install
	touch $@
