#!/bin/sh -eux

echo "int main(){ return 0; }" | clang -g -v -x c - 2> build.log
# Make sure that clang is using the expected flag to use DWARF 4
grep -q "\-dwarf-version=4" build.log
# Inspect the binary to double check expected DWARF version
llvm-dwarfdump a.out | grep -i version | grep 0x0004
