#!/bin/sh -e
VER=3.82
test -e make-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/make/make-$VER.tar.bz2
rm -rf make-$VER;tar -xf make-$VER.tar.bz2
cd make-$VER
./configure --prefix=/ --disable-nls
make CFLAGS="$CFLAGS -D__BEOS__"
make DESTDIR=$R install
cd ..
rm -rf make-$VER
