#!/bin/bash

IMAGE="$1"
MACHINE=orangepi-pc
KERNEL=output/orangepi/linux/build/arch/arm/boot/zImage
DTB=output/orangepi/linux/build/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
SIZE=$(stat --printf="%s" $IMAGE)

for power in $(seq 10 40); do
    power2size=$((2**$power))
    if [[ $SIZE -eq $power2size ]]; then
        echo "Image size, $power2size, is already a power-of-2"
        break
    elif [[ $SIZE -lt $power2size ]]; then
        echo "Image size is $SIZE"
        echo "Resize to a power-of-2, $power2size"
        qemu-img resize -f raw output/orangepi/qemu.img $power2size
        break
    fi
done

set -x
qemu-system-arm \
    -M "$MACHINE" \
    -nic user,ipv6=off,mac=52:54:98:76:54:32,hostfwd=tcp::$CONFIG_SSH_PORT-10.0.0.10:22 \
    -no-reboot -nographic \
    -kernel "$KERNEL" \
    -append "console=ttyS0 root=/dev/mmcblk0 init=/sbin/init" \
    -dtb "$DTB" \
    -drive file="$IMAGE",format=raw \
