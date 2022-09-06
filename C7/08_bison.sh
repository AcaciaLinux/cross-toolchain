#!/bin/bash

set -e

NAME=bison
VERSION=3.8.2

echo "Creating directories..."
mkdir -pv /sources
mkdir -pv /builds

cd /builds

echo "Removing old build directory if existing..."
rm -rf /builds/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf /sources/$NAME-$VERSION.tar.xz
cd /builds/$NAME-$VERSION

./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2

make -j$(nproc)

make install
