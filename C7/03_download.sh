#!/bin/sh

set -e

GETTEXT_VERSION=0.21
BISON_VERSION=3.8.2
PERL_VERSION=5.36.0
PYTHON3_VERSION=3.10.6
TEXINFO_VERSION=6.8
UTIL_LINUX_VERSION=2.38.1

if [ -z ${LFS} ];
then 	
	echo "LFS variable is not set!"
	exit 1
fi

wget --continue -P $LFS/sources https://ftp.gnu.org/gnu/gettext/gettext-$GETTEXT_VERSION.tar.xz
wget --continue -P $LFS/sources https://ftp.gnu.org/gnu/bison/bison-$BISON_VERSION.tar.xz
wget --continue -P $LFS/sources https://www.cpan.org/src/5.0/perl-$PERL_VERSION.tar.xz
wget --continue -P $LFS/sources https://www.python.org/ftp/python/$PYTHON3_VERSION/Python-$PYTHON3_VERSION.tar.xz
wget --continue -P $LFS/sources https://ftp.gnu.org/gnu/texinfo/texinfo-$TEXINFO_VERSION.tar.xz
wget --continue -P $LFS/sources https://www.kernel.org/pub/linux/utils/util-linux/v2.38/util-linux-$UTIL_LINUX_VERSION.tar.xz
# wget --continue -P $LFS -$VERSION.tar.xz
