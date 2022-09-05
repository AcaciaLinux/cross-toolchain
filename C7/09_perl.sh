#!/bin/sh

set -e

NAME=perl
VERSION=5.36.0

echo "Creating directories..."
mkdir -pv /sources
mkdir -pv /builds

cd /builds

echo "Removing old build directory if existing..."
rm -rf /builds/$NAME-$VERSION

echo "Extracting $NAME..."
tar xpf /sources/$NAME-$VERSION.tar.xz
cd /builds/$NAME-$VERSION

sh Configure -des                                        \
             -Dprefix=/usr                               \
             -Dvendorprefix=/usr                         \
             -Dprivlib=/usr/lib/perl5/5.36/core_perl     \
             -Darchlib=/usr/lib/perl5/5.36/core_perl     \
             -Dsitelib=/usr/lib/perl5/5.36/site_perl     \
             -Dsitearch=/usr/lib/perl5/5.36/site_perl    \
             -Dvendorlib=/usr/lib/perl5/5.36/vendor_perl \
             -Dvendorarch=/usr/lib/perl5/5.36/vendor_perl

make -j$(nproc)

make install
