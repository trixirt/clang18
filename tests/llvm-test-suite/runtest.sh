#!/bin/sh
set -e
set -x

cmake -G Ninja /usr/share/llvm-test-suite/ -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -DTEST_SUITE_LIT_FLAGS="-svj1"
ninja -j 1 check
