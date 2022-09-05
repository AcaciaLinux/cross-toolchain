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

mkdir -p $LFS_SOURCES
mkdir -p $LFS_BUILDS
