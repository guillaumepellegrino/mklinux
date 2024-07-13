#!/bin/bash

set -e

component="$1"
COMPONENT="$(echo $component | tr '[:lower:]' '[:upper:]' | sed "s/-/_/" )"
source "./rules/$component/$component.sh"

printdeps()
{
    for dep in $DEPENDENCIES; do
        printf "component/$dep/install "
    done
}

cat << EOF
# $component component rules
components-\$(CONFIG_$COMPONENT): component/$component/release

component/$component/download:
	\$(call download,$component)

component/$component/configure: component/$component/download $(printdeps)
	\$(call configure,$component)

component/$component/compile: component/$component/configure
	\$(call compile,$component)

component/$component/mkpackage: component/$component/compile
	\$(call mkpackage,$component)

component/$component/install: component/$component/mkpackage
	\$(call install,$component)

component/$component/release: component/$component/install
	\$(call release,$component)

component/$component/scp: component/$component/mkpackage
	\$(call scp,$component)

component/$component/clean:
	rm -rf component/$component/

component/$component/download-force:
	\$(call download,$component)

component/$component/configure-force: component/$component/download $(printdeps)
	\$(call configure,$component)

component/$component/compile-force: component/$component/configure
	\$(call compile,$component)

component/$component/mkpackage-force: component/$component/compile
	\$(call mkpackage,$component)

component/$component/install-force: component/$component/mkpackage
	\$(call install,$component)

component/$component/release-force: component/$component/install
	\$(call release,$component)

EOF


