#!/bin/sh -e
VER=2.21.1
TOP=$(pwd)
test -e binutils-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/binutils/binutils-$VER.tar.bz2
rm -rf binutils-$VER;tar -xf binutils-$VER.tar.bz2
cd binutils-$VER

sed -i 's/linux-gnu\* |/linux-gnu* | linux-musl* |/' config.sub
echo "#define __pid_t int" >include/features.h

./configure --target=$A-pc-linux-musl --disable-shared --disable-nls --prefix=/
make
make DESTDIR=$R tooldir=/ install

cd ..
rm -rf binutils-$VER
