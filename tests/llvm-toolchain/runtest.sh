#!/bin/sh

# Tests for using a full LLVM toolchain: clang + compiler-rt + libcxx + lld

set -ex pipefail

# Test compile a C program.
cat << EOF | \
	clang -fuse-ld=lld -rtlib=compiler-rt -x c - && \
	./a.out | grep 'Hello World'

#include<stdio.h>
int main(int argc, char **argv) {
  printf("Hello World\n");
  return 0;
}
EOF

# Test compile a C++ program.
cat << EOF | \
	clang++ -x c++ -fuse-ld=lld -rtlib=compiler-rt -stdlib=libc++ - && \
	./a.out | grep 'Hello World'

#include <iostream>
int main(int argc, char **argv) {
  std::cout << "Hello World\n";
  return 0;
}
EOF
