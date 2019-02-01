#!/bin/sh
set -e
set -x

cp -r /usr/share/llvm-test-suite/ABI-Testsuite .
cd ABI-Testsuite
python3 linux-x86.py clang test -v --path /usr/lib64/llvm/ -j 1
