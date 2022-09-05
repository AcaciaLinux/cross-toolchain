#!/bin/sh

set -e

if [ "$EUID" -ne 0 ]
  then echo "This scripts needs to be run as root"
  exit
fi

echo "Cleaning up..."
rm -rf /usr/share/{info,man,doc}/*

find /usr/{lib,libexec} -name \*.la -delete

rm -rf /tools
