#!/bin/bash
if [ -z ${LFS} ];
then 	
	echo "LFS variable is not set!"
	exit 1
fi

umount $LFS/dev/pts
umount $LFS/{sys,proc,run,dev}
