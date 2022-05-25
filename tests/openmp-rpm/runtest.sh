#!/bin/bash

set -ex

${BUILDDEP_CMD} -y test.spec
rpmbuild --define '_sourcedir .' --define '_builddir .' -bb test.spec
