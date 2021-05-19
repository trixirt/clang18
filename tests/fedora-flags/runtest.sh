#!/bin/bash

set -ex pipefail

cflags=`rpm -D '%toolchain clang' -E %{build_cflags}`
cxxflags=`rpm -D '%toolchain clang' -E %{build_cxxflags}`
ldflags=`rpm -D '%toolchain clang' -E %{build_ldflags}`


# Test a c program
clang $cflags -c hello.c -o hello.o
clang $cflags -c main.c -o main.o
clang $ldflags -o hello main.o hello.o
./hello | grep "Hello World"

# Test a cxx program
clang++ $cxxflags -c hello.cpp -o hello-cpp.o
clang++ $cxxflags -c main.cpp -o main-cpp.o
clang++ $ldflags -o hello-cpp main-cpp.o hello-cpp.o
./hello-cpp | grep "Hello World"
