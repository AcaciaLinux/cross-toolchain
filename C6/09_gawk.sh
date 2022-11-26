#!/bin/bash

NAME=gawk
VERSION=5.1.1

if [ -z ${LFS} ];
then 	
	echo "LFS variable is not set!"
	exit 1
fi

if [ -z ${LFS_TGT} ];
then 	
	echo "LFS_TGT variable is not set!"
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

wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/gawk/gawk-$VERSION.tar.xz

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf $LFS_SOURCES/$NAME-$VERSION.tar.xz
cd $LFS_BUILDS/$NAME-$VERSION

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make

make DESTDIR=$LFS install
