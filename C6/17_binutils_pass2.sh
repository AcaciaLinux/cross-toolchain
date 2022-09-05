#!/bin/sh

set -e

NAME=binutils
VERSION=2.39

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

wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.xz

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf $LFS_SOURCES/$NAME-$VERSION.tar.xz
cd $LFS_BUILDS/$NAME-$VERSION

sed '6009s/$add_dir//' -i ltmain.sh

mkdir -v build
cd       build

../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --enable-gprofng=no        \
    --disable-werror           \
    --enable-64-bit-bfd

make

make DESTDIR=$LFS install

rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}
