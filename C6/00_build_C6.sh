#!/bin/bash

set -e

if [ -z ${LFS} ];
then 	
	echo "LFS variable is not set!"
	exit 1
fi

if [ -z ${LFS_TGT} ];
then 	
	echo "LFS_TGT variable is not set!"
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

LOGDIR=$LFS/buildLogs/C6

mkdir -pv $LFS/buildLogs/C6

CURDIR=$(dirname $0)

{ time $CURDIR/02_m4.sh ; } 2>&1 | tee $LOGDIR/02_m4.txt
{ time $CURDIR/03_ncurses.sh ; } 2>&1 | tee $LOGDIR/03_ncurses.txt
{ time $CURDIR/04_bash.sh ; } 2>&1 | tee $LOGDIR/04_bash.txt
{ time $CURDIR/05_coreutils.sh ; } 2>&1 | tee $LOGDIR/05_coreutils.txt
{ time $CURDIR/06_diffutils.sh ; } 2>&1 | tee $LOGDIR/06_diffutils.txt
{ time $CURDIR/07_file.sh ; } 2>&1 | tee $LOGDIR/07_file.txt
{ time $CURDIR/08_findutils.sh ; } 2>&1 | tee $LOGDIR/08_findutils.txt
{ time $CURDIR/09_gawk.sh ; } 2>&1 | tee $LOGDIR/09_gawk.txt
{ time $CURDIR/10_grep.sh ; } 2>&1 | tee $LOGDIR/10_grep.txt
{ time $CURDIR/11_gzip.sh ; } 2>&1 | tee $LOGDIR/11_gzip.txt
{ time $CURDIR/12_make.sh ; } 2>&1 | tee $LOGDIR/12_make.txt
{ time $CURDIR/13_patch.sh ; } 2>&1 | tee $LOGDIR/13_patch.txt
{ time $CURDIR/14_sed.sh ; } 2>&1 | tee $LOGDIR/14_sed.txt
{ time $CURDIR/15_tar.sh ; } 2>&1 | tee $LOGDIR/15_tar.txt
{ time $CURDIR/16_xz.sh ; } 2>&1 | tee $LOGDIR/16_xz.txt
{ time $CURDIR/17_binutils_pass2.sh ; } 2>&1 | tee $LOGDIR/17_binutils_pass2.txt
{ time $CURDIR/18_gcc_pass2.sh ; } 2>&1 | tee $LOGDIR/18_gcc_pass2.txt
# { time $CURDIR/.sh ; } 2>&1 | tee $LOGDIR/.txt
