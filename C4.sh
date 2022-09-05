#!/bin/sh

set -e

if [ -z ${LFS} ];
then 	
	echo "LFS variable is not set!"
	exit 1
fi

SCRIPTSDIR=$(dirname $0)

### 4.2

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i | true
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools

### 4.3

groupadd lfs | true
useradd -s /bin/bash -g lfs -m -k /dev/null lfs | true

passwd -d lfs

chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

### Additional copies
mkdir -p $LFS/scripts
cp -rfv $SCRIPTSDIR $LFS/scripts

chown -v lfs $LFS/scripts

### 4.4

NUM_CPUS=$(nproc)

echo "exec env -i HOME=\$HOME TERM=\$TERM PS1='\u:\w\$ ' /bin/bash" > /home/lfs/.bash_profile
#echo "HOME=\$HOME TERM=\$TERM PS1='\u:\w\$ ' exec /bin/bash" > /home/lfs/.bash_profile

echo "
set +h
umask 022
LFS=$LFS
LFS_SOURCES=$LFS/sources
LFS_BUILDS=$LFS/builds
MAKEFLAGS=-j$NUM_CPUS
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:\$PATH; fi
PATH=$LFS/tools/bin:\$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE MAKEFLAGS LFS_SOURCES LFS_BUILDS
echo \"LFS is at $LFS\"
echo \"LFS scripts are at $LFS/scripts\"
cd $LFS/scripts
" > /home/lfs/.bashrc

chown -v lfs:lfs /home/lfs/.bashrc
chown -v lfs:lfs /home/lfs/.bash_profile

su - lfs --session-command "source ~/.bash_profile"
