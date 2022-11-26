#!/bin/bash

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

VERSION=2.36
LFS_VERSION=11.2-rc1

wget --continue -P $LFS_SOURCES https://ftp.gnu.org/gnu/glibc/glibc-$VERSION.tar.xz
wget --continue -P $LFS_SOURCES https://www.linuxfromscratch.org/patches/lfs/$LFS_VERSION/glibc-$VERSION-fhs-1.patch

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/glibc-$VERSION

echo "Extracting..."
tar xpf $LFS_SOURCES/glibc-$VERSION.tar.xz
cd $LFS_BUILDS/glibc-$VERSION

case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

patch -Np1 -i $LFS_SOURCES/glibc-$VERSION-fhs-1.patch

mkdir -pv build
cd build

echo "rootsbindir=/usr/sbin" > configparms

../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=$LFS/usr/include    \
      libc_cv_slibdir=/usr/lib

make
make DESTDIR=$LFS install

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

### Testing
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep '/ld-linux'

rm -v dummy.c a.out

$LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders
