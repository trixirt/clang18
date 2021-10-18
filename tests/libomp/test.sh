#!/bin/bash

set -exo pipefail

clang -fopenmp openmp-compile-link-test.c

./a.out | grep "Num Threads: 1"
