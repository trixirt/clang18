#!/bin/bash

set -x

status=0

# arhmfp not tested due to rhbz#1918924.
arches="s390x ppc64le x86_64 i386 aarch64"

for arch in $arches; do
	root="fedora-rawhide-$arch"
	mock -r $root --install clang
	mock -r $root --copyin main.c main.cpp hello.c hello.cpp test-clang.sh .
	if mock -r $root --shell bash test-clang.sh; then
		echo "$arch: PASS"
	else
		echo "$arch: FAIL"
		status=1
	fi
done

exit $status
