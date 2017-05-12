#!/bin/bash

NON_ESSENTIAL_BUILD="wget ca-certificates"
RUNTIME="python-minimal libpython-stdlib libgomp1 zlib1g"

# Build dependencies
apt-get update --yes
apt-get install --yes --no-install-recommends ${NON_ESSENTIAL_BUILD}

# Fetch precompiled binary
URL="https://github.com/voutcn/megahit/releases/download/${MEGAHIT_VERSION}/megahit_${MEGAHIT_VERSION}_LINUX_CPUONLY_x86_64-bin.tar.gz"
fetch_archive.sh ${URL} megahit
ln -s /usr/local/megahit/* /usr/local/bin/

# Clean up dependencies
apt-get autoremove --purge --yes ${NON_ESSENTIAL_BUILD}
apt-get clean

# Install required files
apt-get install --yes --no-install-recommends ${RUNTIME}
rm -rf /var/lib/apt/lists/*
