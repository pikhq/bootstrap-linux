#!/bin/sh -x
genext2fs -d out/ -m 5 -i 1024 -U -b 1048576 filesystem.img
