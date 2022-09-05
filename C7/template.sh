#!/bin/sh

set -e

NAME=
VERSION=

echo "Creating directories..."
mkdir -pv /sources
mkdir -pv /builds

wget --continue -P /sources -$VERSION.tar.xz

cd /builds

echo "Removing old build directory if existing..."
rm -rf /builds/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf /sources/$NAME-$VERSION.tar.xz
cd /builds/$NAME-$VERSION

make

make install
