#!/bin/sh

set -e

if [ -z ${LFS} ];
then 	
	echo "LFS variable is not set!"
	exit 1
fi

if [ -z ${LFS_SOURCES} ];
then 	
	echo "LFS_SOURCES variable is not set!"
	exit 1
fi

if [ -z ${LFS_BUILDS} ];
then 	
	echo "LFS_BUILDS variable is not set!"
	exit 1
fi

VERSION=5.19.2

wget --continue -P $LFS_SOURCES  https://www.kernel.org/pub/linux/kernel/v5.x/linux-$VERSION.tar.xz

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/linux-$VERSION

echo "Extracting..."
tar xpf $LFS_SOURCES/linux-$VERSION.tar.xz
cd $LFS_BUILDS/linux-$VERSION

make mrproper

make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr
