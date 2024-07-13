#!/bin/bash

COMPONENT="$1"
mkdir -p "rules/$COMPONENT"

cat > "rules/$COMPONENT/$COMPONENT".sh << EOF
URL=TBD
SHA256=TBD
DEPENDENCIES=

configure()
{
    cd \$COMPONENT_BUILD
    \$COMPONENT_SRC/configure --prefix=/usr --host \$CONFIG_TARGET_TRIPLET
}

compile()
{
    make -C \$COMPONENT_BUILD -j\$CONFIG_NUMCPUS all
}

mkpackage()
{
    DESTDIR=\$COMPONENT_PACKAGE make -C \$COMPONENT_BUILD install
}

EOF
chmod +x "rules/$COMPONENT/$COMPONENT".sh

make reconfigure
