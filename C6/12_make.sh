#!/bin/sh

set -e

NAME=make
VERSION=4.3

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

wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/make/make-$VERSION.tar.gz

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf $LFS_SOURCES/$NAME-$VERSION.tar.gz
cd $LFS_BUILDS/$NAME-$VERSION

./configure --prefix=/usr   \
            --without-guile \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make

make DESTDIR=$LFS install
