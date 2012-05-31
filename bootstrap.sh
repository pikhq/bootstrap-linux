#!/bin/sh -e

export PATH=$(pwd)/cross/bin:$(pwd)/utils:$PATH

build cross-scripts/binutils-*
build cross-scripts/gcc-*

export CC=""
export CFLAGS="-Os"
export LDFLAGS="-s"

build cross-scripts/linux-headers-*
build cross-scripts/musl-*

build cross-scripts/gmp-*
build cross-scripts/mpfr-*
build cross-scripts/mpc-*

build build-scripts/musl-*
build build-scripts/binutils-*
build build-scripts/gcc-*
build build-scripts/make-*
build build-scripts/gmp-*
build build-scripts/mpfr-*
build build-scripts/mpc-*
build build-scripts/busybox-*
build build-scripts/linux-*
build build-scripts/finish
