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

LOGDIR=$LFS/buildLogs/C5

mkdir -pv $LFS/buildLogs/C5

CURDIR=$(dirname $0)

{ time $CURDIR/01_prep.sh ; } 2>&1 | tee $LOGDIR/01_prep.txt
{ time $CURDIR/02_binutils.sh ; } 2>&1 | tee $LOGDIR/02_binutils.txt
{ time $CURDIR/03_gcc_pass1.sh ; } 2>&1 | tee $LOGDIR/03_gcc_pass1.txt
{ time $CURDIR/04_linux_api_headers.sh ; } 2>&1 | tee $LOGDIR/04_linux_api_headers.txt
{ time $CURDIR/05_glibc.sh ; } 2>&1 | tee $LOGDIR/05_glibc.txt
{ time $CURDIR/06_libstdcpp.sh ; } 2>&1 | tee $LOGDIR/06_libstdcpp.txt
# { time CURDIR/.sh ; } 2>&1 | tee ${LOGDIR}/.txt
