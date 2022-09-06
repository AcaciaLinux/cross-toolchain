#!/bin/bash

set -e

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

VERSION=12.2.0

GLIBC_VERSION=2.36

MPFR_VERSION=4.1.0
GMP_VERSION=6.2.1
MPC_VERSION=1.2.1

wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.xz
wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/mpfr/mpfr-$MPFR_VERSION.tar.xz
wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.xz
wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/mpc/mpc-$MPC_VERSION.tar.gz

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/gcc-$VERSION

echo "Extracting..."
tar xpf $LFS_SOURCES/gcc-$VERSION.tar.xz
cd $LFS_BUILDS/gcc-$VERSION

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
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
  aarch64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac

mkdir -pv build
cd build

../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=$GLIBC_VERSION \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-decimal-float   \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++

make
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
