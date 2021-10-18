#!/bin/sh -eux

clang++ from_chars.cpp
./a.out 100 | grep 100
