#!/bin/sh -eux

# TODO: tmt does not support a remote git repo as a requirement, one has to clone it "manually".

git clone --depth 1 https://src.fedoraproject.org/rpms/llvm-test-suite.git llvm-test-suite
cd llvm-test-suite/tests/test-suite
./runtest.sh
