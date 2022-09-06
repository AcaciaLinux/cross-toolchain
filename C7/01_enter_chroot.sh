#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "This scripts needs to be run as root"
  exit
fi

if [ -z ${LFS} ];
then 	
	echo "LFS variable is not set!"
	exit 1
fi

## 7.2 - Changing ownership
chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -R root:root $LFS/lib64 ;;
esac

## 7.3 - Preparing virtual kernel file systems
mkdir -pv $LFS/{dev,proc,sys,run}

mount -v --bind /dev $LFS/dev

# mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

## 7.4 - Entering chroot
chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    /bin/bash --login

echo "Unmounting..."

$(dirname $0)/13_unmount.sh
