%global toolchain clang

Name: test
Version: 1
Release: 1
Summary: Test package for checking that RPM packages using -fopenmp build correctly
License: MIT

BuildRequires: clang
BuildRequires: libomp

Source0: test.c

%description
clang was adding RUNPATH to binaries that use OpenMP, and since RUNPATH
is prohibited in Fedora builds, this was causing packages using clang
and OpenMP to fail to build.

References:
https://fedoraproject.org/wiki/Changes/Broken_RPATH_will_fail_rpmbuild
https://github.com/llvm/llvm-project/commit/9b9d08111b618d74574ba03e5cc3d752ecc56f55

%build
clang ${CFLAGS} -fopenmp %{SOURCE0} -o main

%check
./main

%install
install -d %{buildroot}%{_bindir}
install main %{buildroot}%{_bindir}

%files
%{_bindir}/main
