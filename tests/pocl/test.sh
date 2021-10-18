#!/bin/sh -eux

# TODO: tmt does not support a remote git repo as a requirement, one has to clone it "manually".

git clone --depth 1 https://src.fedoraproject.org/rpms/pocl.git pocl
cd pocl/tests/simple-opencl-no-clang
./runtest.sh
