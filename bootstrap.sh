#!/bin/sh -e
A=$(uname -m)
[ "$A" = i686 ] && A=i386
export A
export R=$(pwd)/out/
export CFLAGS="-Os"
export LDFLAGS="-static -s"

./musl-bootstrap.build.sh
export CC=$R/bin/musl-gcc
./binutils.build.sh
./gcc.build.sh
./make.build.sh
./linux.build.sh
./busybox.build.sh
CC=gcc ./musl.build.sh
./finish.build.sh
