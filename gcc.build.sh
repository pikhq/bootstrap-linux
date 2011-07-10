#!/bin/sh -e
VER=4.2.4
TOP=$(pwd)
test -e gcc-core-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/gcc/gcc-$VER/gcc-core-$VER.tar.bz2
rm -rf gcc-$VER;tar -xf gcc-core-$VER.tar.bz2
cd gcc-$VER

sed -i -e 's|/lib/ld-linux.so.2|/lib/ld-musl-i386.so.1|' -e 's|/lib64/ld-linux-x86-64.so.2|/lib/ld-musl-x86_64.so.1|' gcc/config/i386/linux64.h gcc/config/i386/linux.h
sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
sed -i 's/linux-gnu\* |/linux-gnu* | linux-musl* |/' config.sub

CFLAGS="$CFLAGS -D_GNU_SOURCE -fgnu89-inline" ./configure \
    --with-newlib --with-headers=no --prefix=/ \
    --disable-multilib --disable-nls --disable-shared \
    --disable-mudflap --disable-libmudflap --disable-libssp \
    --disable-libgomp --disable-bootstrap --libdir=/lib \
    --libexecdir=/lib --mandir=/share/man --infodir=/share/info \
    --target=$A-unknown-linux-musl --host=$A-unknown-linux-musl

make
make DESTDIR=$R install
ln -sf gcc $R/bin/cc
cd ..
rm -rf gcc-$VER
