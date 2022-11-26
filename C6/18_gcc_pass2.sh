#!/bin/bash

NAME=gcc
VERSION=12.2.0

MPFR_VERSION=4.1.0
GMP_VERSION=6.2.1
MPC_VERSION=1.2.1

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

wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.xz
wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/mpfr/mpfr-$MPFR_VERSION.tar.xz
wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.xz
wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/mpc/mpc-$MPC_VERSION.tar.gz

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf $LFS_SOURCES/$NAME-$VERSION.tar.xz
cd $LFS_BUILDS/$NAME-$VERSION

#Extract extra tooling
echo "Extracting mpfr..."
tar xpf $LFS_SOURCES/mpfr-$MPFR_VERSION.tar.xz
echo "Extracting gmp..."
tar xpf $LFS_SOURCES/gmp-$GMP_VERSION.tar.xz
echo "Extracting mpc..."
tar xpf $LFS_SOURCES/mpc-$MPC_VERSION.tar.gz

mv -v mpfr-4.1.0 mpfr
mv -v gmp-6.2.1 gmp
mv -v mpc-1.2.1 mpc

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
  ;;
esac

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -v build
cd       build

../configure                                       \
    --build=$(../config.guess)                     \
    --host=$LFS_TGT                                \
    --target=$LFS_TGT                              \
    LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc      \
    --prefix=/usr                                  \
    --with-build-sysroot=$LFS                      \
    --enable-initfini-array                        \
    --disable-nls                                  \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --enable-languages=c,c++

make

make DESTDIR=$LFS install

ln -sv gcc $LFS/usr/bin/cc
