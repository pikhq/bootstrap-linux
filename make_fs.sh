#!/bin/sh -x
genext2fs -d out/ -m 5 -N 61440 -U -b 2097152 filesystem.img
