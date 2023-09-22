# Run Makefile.init if the user didn't source yet a build config (with make source/XXX)
# Otherwise, we can run the main Makefile
ifeq ($(CONFIG_NAME),)
include scripts/Makefile.init
else
include scripts/Makefile.main
endif
