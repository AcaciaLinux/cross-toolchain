#!/bin/bash

NAME=gettext
VERSION=0.21

echo "Creating directories..."
mkdir -pv /sources
mkdir -pv /builds

cd /builds

echo "Removing old build directory if existing..."
rm -rf /builds/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf /sources/$NAME-$VERSION.tar.xz
cd /builds/$NAME-$VERSION

./configure --disable-shared

make -j$(nproc)

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
