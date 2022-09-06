#!/bin/bash

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

VERSION=2.39

wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.xz

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/-$VERSION

echo "Extracting..."
tar xpf $LFS_SOURCES/binutils-$VERSION.tar.xz
cd $LFS_BUILDS/binutils-$VERSION

mkdir -pv build
cd build

../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror

make
make install
