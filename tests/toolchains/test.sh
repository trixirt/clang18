#!/bin/sh -eux

set pipefail

if [ -z "${CXXLIBS:-}" ]; then
  echo "CXXLIBS variable is a required input but it's not specified!"
  echo "Test metadata should have picked a proper value, depending on distro."
  exit 1
fi

status=0

test_toolchain() {

    toolchain=$@
    args=""

    while [ $# -gt 0 ]; do
        case $1 in
            clang)
                compiler=$1
                src=hello.c
                ;;
            clang++)
                compiler=$1
                src=hello.cpp
                ;;
            compiler-rt)
                args="$args -rtlib=$1"
                ;;
            libc++)
                args="$args -stdlib=$1"
                ;;
            libstdc++)
                args="$args -stdlib=$1"
                ;;
            lld)
                args="$args -fuse-ld=$1"
                ;;
            *)
                args="$args $1"
                ;;
        esac
    shift
    done

    cmd="$compiler $args $src"
    rm -f a.out
    echo "* $toolchain"
    echo "  command: $cmd"
    if $cmd && ./a.out | grep -q 'Hello World'; then
        echo "  PASS"
    else
        echo "  FAIL"
        status=1
    fi
}

clang --version
# Repoquery is needed instead yum info for compatibility with RHEL-7
repoquery -i --installed $(rpm -qf $(which clang)) | grep ^Source
echo ""

for compiler in clang clang++; do
    for rtlib in "" compiler-rt; do
        for linker in "" lld; do
            for cxxlib in "" $CXXLIBS; do
                if [ "$compiler" = "clang" -a -n "$cxxlib" ]; then
                    continue
                fi
                for args in "" -static; do
                    # Skip known failures
                    # TODO: Fix these
                    if [[ "$args" = "-static" && "$rtlib" = "compiler-rt" ]]; then
                        continue
                    fi

                    # Static libc++ needs -pthread
                    if [[ "$args" = "-static" && "$cxxlib" = "libc++" ]]; then
                      args="$args -pthread"
                    fi

                    # lld is not supported in s390x
                    if [[ "$(uname -m)" = "s390x" && "$linker" = "lld" ]]; then
                      continue
                    fi

                    test_toolchain $compiler $rtlib $linker $cxxlib $args
                done
            done
        done
    done
done

exit $status
