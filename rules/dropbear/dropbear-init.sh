#!/bin/sh

start()
{
    dropbearconvert openssh dropbear /etc/dropbear/ssh_rsa_host_key /etc/dropbear/dropbear_rsa_host_key

    # start ssh server
    dropbear
}

case $1 in
    start)
        start
        ;;
    *)
        echo "Usage: $0 [start]"
        ;;
esac
