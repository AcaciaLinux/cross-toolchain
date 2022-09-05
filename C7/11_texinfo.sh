#!/bin/sh

set -e

NAME=texinfo
VERSION=6.8

echo "Creating directories..."
mkdir -pv /sources
mkdir -pv /builds

cd /builds

echo "Removing old build directory if existing..."
rm -rf /builds/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf /sources/$NAME-$VERSION.tar.xz
cd /builds/$NAME-$VERSION

./configure --prefix=/usr

make -j$(nproc)

make install
