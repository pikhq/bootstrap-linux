#!/bin/sh -e
mkdir -p $R/etc/
mkdir -p $R/proc
mkdir -p $R/dev
mkdir -p $R/sys
mkdir -p $R/root
mkdir -p $R/mnt/
mkdir -p $R/tmp/

ln -s bin $R/sbin
ln -s / $R/usr

cat >$R/etc/inittab <<EOF
::sysinit:/etc/rc
tty1:2345:respawn:/bin/getty 38400 tty1
tty2:23:respawn:/bin/getty 38400 tty2
tty3:23:respawn:/bin/getty 38400 tty3
tty4:23:respawn:/bin/getty 38400 tty4
tty5:23:respawn:/bin/getty 38400 tty5
tty6:23:respawn:/bin/getty 38400 tty6
::ctrlaltdel:/bin/umount -a -r
::ctrlaltdel:/bin/swapoff -a
EOF
cat >$R/etc/rc <<EOF
#!/bin/sh
mount -t proc proc /proc
mount -o remount,rw /
mount -t sysfs sysfs /sys
mount -t tmpfs mdev /dev
mkdir /dev/pts
mount -t devpts devpts /dev/pts
echo /bin/mdev > /proc/sys/kernel/hotplug
mdev -s
EOF

cat >$R/etc/passwd <<EOF
root::0:0:root:/root:/bin/sh
EOF

chmod +x $R/etc/rc

