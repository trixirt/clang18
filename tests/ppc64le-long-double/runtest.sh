set -e

gcc_output=$(gcc -E -dM -x c /dev/null | grep -e __LONG_DOUBLE_IEEE128__ -e __LONG_DOUBLE_IBM128__)
clang_output=$(clang -E -dM -x c /dev/null | grep -e __LONG_DOUBLE_IEEE128__ -e __LONG_DOUBLE_IBM128__)

echo "gcc:   $gcc_output"
echo "clang: $clang_output"

test "$gcc_output" = "$clang_output"
