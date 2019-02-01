#!/bin/sh
set -e
set -x

clang++ from_chars.cpp
./a.out 100 | grep 100
