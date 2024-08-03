#!/bin/bash

IMAGE="$1"

set -x
qemu-system-x86_64 \
    -nic user,ipv6=off,mac=52:54:98:76:54:32,hostfwd=tcp::$CONFIG_SSH_PORT-10.0.0.10:22 \
    -no-reboot -nographic \
    -kernel component/linux/build/arch/x86_64/boot/bzImage \
    -drive file="$IMAGE",format=raw \
    -append "console=ttyS0 root=/dev/sda init=/sbin/init"
