
# Usage
Make a minimalist linux OS to be run on a qemu machine.

# Build
##  1. Choose your platform configuration
```
~/Workspace/mklinx$ make config/x86_64
```
=> This will auto-generate `output/x86_64/Makefile` which is used to describe your platform config.

- Tips 1: make config/ + TAB for listing all supported platorms.
- Tips 2: Edit or add your platform configuration in config/{$platform}/
- Tips 3: Edit your build configuration in output/{platform}/config.mk

## 2. Start the build generation
```
~/Workspace/mklinx$ cd output/x86_64
~/Workspace/mklinx/output/x86_64$ make -j15
```

It will generate a minimalist linux image which can be run under qemu.

The build is defined in 6x stages:
- download
- configure
- compile
- package
- install (optional)
- release (optional)

- Build system will download, configure, compile, install and release each component before generating a qemu image.
- Build system is heavy relying on Makefile dependencies, allowing fearless parallelism as long as component dependencies are correctly defined in rules/.
- Each componant can be also built individually for debugging purpose.

# Run the linux image with qemu
```
make runqemu
```

# SSH into qemu
```
make ssh
```

# Define a new component
- Simply add a new rule in rules/$component/$component.sh
- The new rule is a shell script which will be sourced by the build system. It should allow the build system to know how to download, configure, compile and package this component.
- This script shall contain:
  - `URL` variable to define the component download URL.
  - `SHA256` variable to verify the downloaded component checksum in order to ensure its integrity.
  - `DEPENDENCIES` variable to define the component dependencies, like others libraries.
  - configure() function (optional) to generate the component default config (Usually by calling ./configure or make defconfig).
  - compile() funcion (optional) to build the component.
  - mkpackage() funcion (optional) to install the component in the package directory.
- The build system will define some variables proper for each component which can be used in the rule script:
  - `COMPONENT_RULE` : The directory where is defined the component script rule.
  - `COMPONENT_DOWNLOAD` : The directory where is downloaded this component.
  - `COMPONENT_SRC` : The directory where is extracted the component sources.
  - `COMPONENT_BUILD` : The directory where the component shall be built.
  - `COMPONENT_PACKAGE` : The directory where the component shall be installed.
- Additionally, the global configuration contained in `config.mk` and `defaults.mk` is sourced by the top Makefile and can be used in the component rules. It contains the env var usually needed for cross-compilation like `CC`, `LD`, `CROSS_COMPILE`, `CFLAGS`, `LDFLAGS`, and more.
