#!/bin/bash

usage() {
    echo "usage `basename $0` [OPTIONS]"
    echo "  --threads NUM       The number of threads to use for running tests."
}

thread_args=""
repo_url=https://github.com/opencollab/llvm-toolchain-integration-test-suite

while [ $# -gt 0 ]; do
    case $1 in
        --threads)
            shift
            threads="$1"
            ;;
        * )
            echo "unknown option: $1"
            echo ""
            usage
            exit 1
            ;;
    esac
    shift
done

if [ -n "$threads" ]; then
  thread_args="-j$threads"
fi

set -xe

cd $(mktemp -d -p /var/tmp)
git clone $repo_url
cd llvm-toolchain-integration-test-suite
mkdir _build && cd _build
cmake .. -GNinja
ninja $thread_args check
