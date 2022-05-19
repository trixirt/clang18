set -e

fedora_release=`rpm -E %{fedora}`
mock_root=fedora-$fedora_release-ppc64le
triple=ppc64le-redhat-linux

mock -r $mock_root --isolation=simple --install gcc
gcc_output=$(mock -r $mock_root --isolation=simple -q --shell gcc -E -dM -x c /dev/null | grep -e __LONG_DOUBLE_IEEE128__ -e __LONG_DOUBLE_IBM128__)
clang_output=$(clang -target $triple  -E -dM -x c /dev/null | grep -e __LONG_DOUBLE_IEEE128__ -e __LONG_DOUBLE_IBM128__)

echo "gcc:   $gcc_output"
echo "clang: $clang_output"

test "$gcc_output" = "$clang_output"
