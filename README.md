# Usage
Make a minimalist linux OS to be run on a qemu machine.

# Build
## 1. Configure
The supported platform are defined under config/ directory.
The build system can be configured with one of the supported platform with this command:
```
make defconfig/orangepi
make defconfig/qemu_x86_64
```

Or you can generate the default config for all supported platforms with:
```
make defconfig/all
```

The command generate a default configuration which can be edited under `.${PLATFORM}.mk`

Tips: make defconfig/ + TAB for listing all supported platforms

## 2. Source the build environment
First, source your build configuration:
```
make source/x86_64
```

## 3. Start the build generation
Then you can simply start the image generation with:
```
make -j15
```

It will generate a minimalist linux image which can be run under qemu.

The build is defined in 5x stages:
- download
- configure
- compile
- install
- release

The stages for each components are defined in the rules/ directory.
Each componant can be also built individually for debugging purpose.

Tips:
- make output/${PLATFORM}/ + TAB for listing all components
- make output/${PLATFORM}/${COMPONENT}/(clean|download|configure|compile|mkpackage|install||release) for available actions

## 4. Run the linux image with qemu:
```
make runqemu
```

## 5. SSH into qemu:
```
make ssh
```

# Build all
To build all available platforms in parallel:
```
make defconfig/all
make build/all
```
