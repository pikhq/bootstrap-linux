#!/bin/sh -e
export A=$(uname -m)
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
./musl.build.sh
./finish.build.sh
