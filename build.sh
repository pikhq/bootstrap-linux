#!/bin/sh -e
export A=$(uname -m)
export R=$(pwd)/out/
export CFLAGS="-Os"
export LDFLAGS="-static -s"
export CC=gcc

./musl.build.sh
./binutils.build.sh
./gcc.build.sh
./make.build.sh
./busybox.build.sh
./sed.build.sh
./linux.build.sh
./finish.build.sh
