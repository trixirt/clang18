#!/bin/sh -eux

# Tests for using a full LLVM toolchain: clang + compiler-rt + libcxx + lld

set pipefail

if [ -z "${CXXLIB:-}" ]; then
  echo "CXXLIB variable is a required input but it's not specified!"
  echo "Test metadata should have picked a proper value, depending on distro."
  exit 1
fi

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
	clang++ -x c++ -fuse-ld=lld -rtlib=compiler-rt -stdlib="$CXXLIB" - && \
	./a.out | grep 'Hello World'

#include <iostream>
int main(int argc, char **argv) {
  std::cout << "Hello World\n";
  return 0;
}
EOF
