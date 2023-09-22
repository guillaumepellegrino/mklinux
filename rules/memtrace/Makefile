MEMTRACE_PKV=memtrace-1.1.0

$(RULE)/memtrace/download:
	./scripts/download.sh memtrace https://github.com/guillaumepellegrino/memtrace/archive/refs/tags/v1.1.0.tar.gz cd4fb324a44dc3c883a1b31675fa59ad
	mkdir -p $(dir $@);	touch $@

$(RULE)/memtrace/configure: $(RULE)/memtrace/download
	touch $@

$(RULE)/memtrace/compile: $(RULE)/memtrace/configure
	@echo "Compile memtrace"
	make O=$(OUTPUT)/memtrace/build CC=$(CONFIG_CC) -C src/memtrace/$(MEMTRACE_PKV) -j$(CONFIG_NUMCPUS)
	touch $@

$(RULE)/memtrace/mkpackage: $(RULE)/memtrace/compile
	make DESTDIR=$(OUTPUT)/memtrace/package O=$(OUTPUT)/memtrace/build -C src/memtrace/$(MEMTRACE_PKV) -f Makefile.target install
	touch $@

