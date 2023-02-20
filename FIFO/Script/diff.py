#!/usr/bin/python
import os
import sys

rd_file = "../VCS/out/rd.txt"
wr_file = "../VCS/out/wr.txt"

veri = True

with open(rd_file) as rd_fd, open(wr_file) as wr_fd:
    num = 1
    for rd_line in rd_fd:
        wr_line = wr_fd.readline()
        if wr_line != rd_line:
            print num, "line: " + "wr:", wr_line[0:-1], " rd:", rd_line[0:-1]
            veri = False
        num = num + 1;

if veri:
    print("Verification success")
else:
    print("Verification failure")
    sys.exit(-1)
