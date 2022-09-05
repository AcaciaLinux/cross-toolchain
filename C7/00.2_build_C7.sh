#/bin/sh

LOGDIR=/buildLogs/C7

mkdir -pv /buildLogs/C7

CURDIR=$(dirname $0)

{ time $CURDIR/07_gettext.sh ; } 2>&1 | tee $LOGDIR/07_gettext.txt
{ time $CURDIR/08_bison.sh ; } 2>&1 | tee $LOGDIR/08_bison.txt
{ time $CURDIR/09_perl.sh ; } 2>&1 | tee $LOGDIR/09_perl.txt
{ time $CURDIR/10_python3.sh ; } 2>&1 | tee $LOGDIR/10_python3.txt
{ time $CURDIR/11_texinfo.sh ; } 2>&1 | tee $LOGDIR/11_texinfo.txt
{ time $CURDIR/12_util-linux.sh ; } 2>&1 | tee $LOGDIR/12_util-linux.txt

# { time $CURDIR/.sh ; } 2>&1 | tee $LOGDIR/.txt
