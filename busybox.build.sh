#!/bin/sh -e
VER=1.18.5
test -e busybox-$VER.tar.bz2 || wget http://busybox.net/downloads/busybox-$VER.tar.bz2
rm -rf busybox-$VER;tar -xf busybox-$VER.tar.bz2
cd busybox-$VER

patch -p1 <../busybox.patch

make allnoconfig HOSTCFLAGS="-D_GNU_SOURCE" KCONFIG_ALLCONFIG=../busybox.config
make CFLAGS_busybox="-Wl,-z,muldefs" HOSTCFLAGS="-D_GNU_SOURCE" HOSTCC=gcc CC=$CC
cp busybox $R/bin/
cd ..
rm -rf busybox-$VER

cd $R/bin/
for i in $(./busybox --list);do
    ln -s busybox $i
done
