#!/bin/sh -e

export PATH=$(pwd)/cross/bin:$(pwd)/utils:$PATH

: ${A:=$(uname -m)}

build cross-scripts/binutils-*
build cross-scripts/gcc-*

export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"

build cross-scripts/linux-headers-*
build cross-scripts/musl-*

build build-scripts/musl-*
build build-scripts/binutils-*
build build-scripts/gcc-*
build build-scripts/make-*
build build-scripts/busybox-*
build build-scripts/linux-*
build build-scripts/finish
