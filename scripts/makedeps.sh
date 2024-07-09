#!/bin/bash

set -e

component="$1"
source "./rules/$component/$component.sh"


cat << EOF
# $component component rules
download: component/$component/download
compile: component/$component/compile
configure: component/$component/configure
mkpackage: component/$component/mkpackage
install: component/$component/install
release: component/$component/release

component/$component/download:
	\$(call download,$component)

component/$component/configure: component/$component/download
	\$(call configure,$component)

component/$component/compile: component/$component/configure $(for dep in $DEPENDENCIES; do echo "$dep/compile"; done)
	\$(call compile,$component)

component/$component/mkpackage: component/$component/compile
	\$(call mkpackage,$component)

component/$component/install: component/$component/mkpackage
	\$(call install,$component)

component/$component/release: component/$component/install
	\$(call release,$component)

component/$component/clean:
	rm -rf $component/

component/$component/download-force:
	\$(call download,$component)

component/$component/configure-force: component/$component/download
	\$(call configure,$component)

component/$component/compile-force: component/$component/configure $(for dep in $DEPENDENCIES; do echo "$dep/compile"; done)
	\$(call compile,$component)

component/$component/mkpackage-force: component/$component/compile
	\$(call mkpackage,$component)

component/$component/install-force: component/$component/mkpackage
	\$(call install,$component)

component/$component/release-force: component/$component/install
	\$(call release,$component)

EOF


