export CONFIG_NUMCPUS?=13
export CONFIG_QEMU?=qemu-system-$(CONFIG_ARCH)

# Build variables
export SCRIPTDIR=$(PWD)/scripts
export RULESDIR=$(PWD)/rules
export STAGINGDIR=$(PWD)/staging
export RELEASEDIR=$(PWD)/release
export CROSS_COMPILE=$(CONFIG_CROSS_COMPILE)
export CC=$(CROSS_COMPILE)gcc
export CXX=$(CROSS_COMPILE)g++
export LD=$(CROSS_COMPILE)ld
export AR=$(CROSS_COMPILE)ar
export STRIP=$(CONFIG_CROSS_COMPILE)strip
export CFLAGS+=-O2 -g -I$(STAGINGDIR)/include -I$(STAGINGDIR)/usr/include
export CXXFLAGS+=-O2 -g -I$(STAGINGDIR)/include -I$(STAGINGDIR)/usr/include
export LDFLAGS+=-L$(STAGINGDIR)/lib -L$(STAGINGDIR)/usr/lib
