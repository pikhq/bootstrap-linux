#!/bin/sh -x
BLOCKS=$(((1024*$(du -m -s out | awk '{print $1}')*12)/10))
genext2fs -z -d out/ -U -i 1024 -b $BLOCKS filesystem.img
resize2fs filesystem.img 500M
