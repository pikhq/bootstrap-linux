#!/bin/sh -e
VER=5.12.3
test -e perl-$VER.tar.gz || wget http://www.cpan.org/src/5.0/perl-$VER.tar.gz
rm -rf perl-$VER;tar -xf perl-$VER.tar.gz
cd perl-$VER

./Configure -des -Uusedl -Acc=$CC \
  -Dldflags="$LDFLAGS -fno-stack-protector" \
  -Doptimize="$CFLAGS -D_GNU_SOURCE -fno-stack-protector" \
  -Dprefix=/ -Dvendorprefix=/  \
  -Dprivlib=/share/perl5/core_perl \
  -Darchlib=/lib/perl5/core_perl \
  -Dsitelib=/share/perl5/site_perl \
  -Dsitearch=/lib/perl5/site_perl \
  -Dvendorlib=/share/perl5/vendor_perl \
  -Dvendorarch=/lib/perl5/vendor_perl \
  -Dscriptdir=/bin \
  -Dsitescript=/bin \
  -Dvendorscript=/bin \
  -Dinc_version_list=none \
  -Dman1dir=/share/man/man1 -Dman1ext=1perl \
  -Dman3dir=/share/man/man3 -Dman3ext=3perl \
  -Dincpath=$R/include -Dusrinc=$R/include -Dlibpth=$R/lib/ \
  -Dlocincpth=$R/local/include 

make miniperl -j1
cp ./miniperl $R/bin/
ln -s miniperl $R/bin/perl
cd ..
rm -rf perl-$VER
