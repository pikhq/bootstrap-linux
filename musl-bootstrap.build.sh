#!/bin/sh -e
VER=0.7.12
test -e musl-$VER.tar.gz || wget http://www.etalabs.net/musl/releases/musl-$VER.tar.gz
rm -rf musl-$VER;tar -xf musl-$VER.tar.gz
cd musl-$VER
cat >config.mak <<EOF
#
# musl config.mak template (original in dist/config.mak)
#

# Target CPU architecture. Supported values: i386, x86_64
ARCH = $A

# Installation prefix. DO NOT use /, /usr, or /usr/local !
prefix = $R

# Installation prefix for musl-gcc compiler wrapper.
exec_prefix = $R

# Location for the dynamic linker ld-musl-$(ARCH).so.1
syslibdir = $R/lib/

# Uncomment if you want to build i386 musl on a 64-bit host
#CFLAGS += -m32

# Uncomment for smaller code size.
#CFLAGS += -fomit-frame-pointer -mno-accumulate-outgoing-args

# Uncomment for warnings (as errors). Might need tuning to your gcc version.
#CFLAGS += -Werror -Wall -Wpointer-arith -Wcast-align -Wno-parentheses -Wno-char-subscripts -Wno-uninitialized -Wno-sequence-point -Wno-missing-braces -Wno-unused-value -Wno-overflow -Wno-int-to-pointer-cast

# Uncomment if you want to disable building the shared library.
SHARED_LIBS =
EOF
make
make install
sed -i 's/-Wl,-dynamic-linker,"$ldso_pathname"//' $R/bin/musl-gcc
rm $R/lib/ld-musl-$A.so.1
cd ..
rm -rf musl-$VER
