#!/bin/bash

set -ex
tmpdir=`mktemp -d`
currentdir=`pwd`

tar -C $tmpdir -xJf $1

test_suite_src=`echo $1 | cut -d . -f 1-4`
pushd $tmpdir
test -d $test_suite_src


UNKNOWN="\
	MultiSource/Benchmarks/mediabench/ \
	MultiSource/Applications/JM/"

#MallocBench/{espresso,cfrac} might be OK
BAD="\
	MultiSource/Benchmarks/MallocBench/ \
	MultiSource/Benchmarks/7zip/"

POSSIBLY_BAD="\
	MultiSource/Benchmarks/Olden/ \
	MultiSource/Benchmarks/Fhourstones/ \
	MultiSource/Benchmarks/ASCI_Purple/SMG2000/ \
	MultiSource/Benchmarks/Fhourstones-3.1/ \
	MultiSource/Benchmarks/McCat/ \
	MultiSource/Applications/spiff/"

#siod: llvm.org/PR38648
BUGGY="\
	MultiSource/Applications/siod"

for f in $UNKNOWN $BAD $POSSIBLY_BAD $BUGGY; do
	test -d $test_suite_src/$f
	rm -Rf $test_suite_src/$f
	basedir=`dirname $f`
	dir=`basename $f`
	cmake_file=$test_suite_src/$basedir/CMakeLists.txt
	test -f $cmake_file
	sed -i s/add_subdirectory\($dir\)//g $cmake_file

done

tar --transform=s/$test_suite_src/$test_suite_src.fedora/ --show-transformed-names -cJf $currentdir/$test_suite_src.fedora.tar.xz $test_suite_src
pushd
rm -Rf $tmpdir
