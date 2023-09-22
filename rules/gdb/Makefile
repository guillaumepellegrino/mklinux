GDB_PKV=gdb-12.1

# FIXME: gdb needs a toolchain with C++ support.
# Build error: #include <cstdlib> // fatal error: cstdlib: No such file or directory

$(RULE)/gdb/download:
	./scripts/download.sh gdb https://ftp.gnu.org/gnu/gdb/$(GDB_PKV).tar.xz 759a1b8d2b4d403367dd0e14fa04643d
	mkdir -p $(dir $@);	touch $@

$(RULE)/gdb/configure: $(RULE)/gdb/download $(RULE)/libstdcpp/install
	@echo "Configure gdb"
	mkdir -p $(OUTPUT)/gdb/build
	cd $(OUTPUT)/gdb/build && $(SRC)/gdb/$(GDB_PKV)/configure --prefix=/usr --host $(CONFIG_TARGET_TRIPLET) --disable-libstdcxx
	touch $@

$(RULE)/gdb/compile: $(RULE)/gdb/configure
	@echo "Compile gdb"
	make -C $(OUTPUT)/gdb/build -j$(CONFIG_NUMCPUS)
	touch $@

$(RULE)/gdb/mkpackage: $(RULE)/gdb/compile
	make DESTDIR=$(OUTPUT)/gdb/package -C $(OUTPUT)/gdb/build  install
	touch $@
