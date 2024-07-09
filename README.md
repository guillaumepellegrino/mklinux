
Build a Linux in two command lines:

1. Build your platform configuration
```
~/Workspace/mklinx$ make config/x86_64
```
=> This will auto-generate `output/x86_64/Makefile` which is used to describe your platform config.

tips:
- Use make auto-completion to display all available platforms !
- Edit or add your platform configuration in config/{$platform}/

2. Build your platform !
```
~/Workspace/mklinx$ cd config/x86_64
~/Workspace/mklinx/config/x86_64$ make -j15
```
- Build system will download, configure, compile, install and release each component before generating a qemu image.
- Build system is heavy relying on Makefile dependencies, allowing fearless parallelism as long as component dependencies are correctly defined in rules/.
- Each component task (download,compile,..) can be run manually with Make.



How to define a new component ?
- Simply add a new rule in rules/$component/$component.sh
- The new rule is a shell script which will be sourced by the build system. It should allow the build system to know how to download, configure, compile and package this component.
- This script shall contain:
-- `URL` variable to define the component download URL.
-- `SHA256` variable to verify the downloaded component checksum in order to ensure its integrity.
-- `DEPENDENCIES` variable to define the component dependencies, like others libraries.
-- configure() function (optional) to generate the component default config (Usually by calling ./configure or make defconfig).
-- compile() funcion (optional) to build the component.
-- mkpackage() funcion (optional) to install the component in the package directory.
- The build system will define some variables proper for each component which can be used in the rule script:
-- `COMPONENT_RULE` : The directory where is defined the component script rule.
-- `COMPONENT_DOWNLOAD` : The directory where is downloaded this component.
-- `COMPONENT_SRC` : The directory where is extracted the component sources.
-- `COMPONENT_BUILD` : The directory where the component shall be built.
-- `COMPONENT_PACKAGE` : The directory where the component shall be installed.
- Additionally, the global configuration contained in `config.mk` and `defaults.mk` is sourced by the top Makefile and can be used in the component rules. It contains the env var usually needed for cross-compilation like `CC`, `LD`, `CROSS_COMPILE`, `CFLAGS`, `LDFLAGS`, and more.
