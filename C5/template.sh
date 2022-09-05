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

VERSION=

wget --continue -P $LFS_SOURCES -$VERSION.tar.xz

cd $LFS_BUILDS

echo "Removing old build directory if existing..."
rm -rf $LFS_BUILDS/-$VERSION

echo "Extracting..."
tar xpf $LFS_SOURCES/-$VERSION.tar.xz
cd $LFS_BUILDS/-$VERSION

mkdir -pv build
cd build