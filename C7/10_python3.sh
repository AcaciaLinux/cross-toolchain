#!/bin/bash

set -e

NAME=Python
VERSION=3.10.6

echo "Creating directories..."
mkdir -pv /sources
mkdir -pv /builds

cd /builds

echo "Removing old build directory if existing..."
rm -rf /builds/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf /sources/$NAME-$VERSION.tar.xz
cd /builds/$NAME-$VERSION

./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip

make -j$(nproc)

make install
