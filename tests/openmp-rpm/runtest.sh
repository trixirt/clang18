#!/bin/bash

set -ex

dnf -y build-dep test.spec
rpmbuild --define '_sourcedir .' --define '_builddir .' -bb test.spec
