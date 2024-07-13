DEPENDENCIES="\$(CONFIG_TOOLCHAIN_COMPONENT)"

configure()
{
    if [ -z "$CONFIG_TOOLCHAIN_COMPONENT" ]; then
        echo "Config option \$CONFIG_TOOLCHAIN_COMPONENT is undefined"
        echo "It must be set to one of the available toolchain:"
        echo rules/*-toolchain
        exit 1
    fi
}
