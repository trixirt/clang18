#!/bin/sh -eux

find /usr -name 'libgcc_s.so*' && echo "int main(){}" | clang -v -x c -
