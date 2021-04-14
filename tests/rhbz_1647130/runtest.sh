#!/bin/sh
set -e
set -x

tmp_cpp=`mktemp -t XXXXX.cpp`
tmp_dir=`mktemp -d`
echo 'int main(int argc, char*argv[]) { while(argc--) new int(); return 0; }' > $tmp_cpp
scan-build -o $tmp_dir clang++ -c $tmp_cpp -o /dev/null
(scan-view --no-browser $tmp_dir/* & WPID=$! && sleep 10s && kill $WPID)

