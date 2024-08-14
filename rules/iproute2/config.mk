PKG_CONFIG:=pkg-config
YACC:=bison
TC_CONFIG_IPSET:=y
LIBDIR:=/usr/lib
IP_CONFIG_SETNS:=y
CFLAGS += -DHAVE_SETNS
CFLAGS += -DHAVE_HANDLE_AT
#HAVE_SELINUX:=y
#LDLIBS += -lselinux 
#CFLAGS += -DHAVE_SELINUX 
#HAVE_ELF:=y
#CFLAGS += -DHAVE_ELF 
#LDLIBS +=  -lelf 
HAVE_MNL:=y
CFLAGS += -DHAVE_LIBMNL 
LDLIBS += -lmnl 
CONF_COLOR:=COLOR_OPT_NEVER

%.o: %.c
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CPPFLAGS) -c -o $@ $<