
STRACE_PKV=strace-6.1

$(RULE)/strace/download:
	./scripts/download.sh strace https://github.com/strace/strace/releases/download/v6.1/strace-6.1.tar.xz cbd758b0545b678cd7ac09c683ade002
	mkdir -p $(dir $@);	touch $@

$(RULE)/strace/configure: $(RULE)/strace/download
	@echo "Configure strace"
	mkdir -p $(OUTPUT)/strace/build
	cd $(OUTPUT)/strace/build && $(SRC)/strace/$(STRACE_PKV)/configure --enable-mpers=no --prefix=/usr --host $(CONFIG_TARGET_TRIPLET)
	touch $@

$(RULE)/strace/compile: $(RULE)/strace/configure
	@echo "Compile strace"
	make -C $(OUTPUT)/strace/build -j$(CONFIG_NUMCPUS)
	touch $@

$(RULE)/strace/mkpackage: $(RULE)/strace/compile
	make DESTDIR=$(OUTPUT)/strace/package -C $(OUTPUT)/strace/build  install
	touch $@
