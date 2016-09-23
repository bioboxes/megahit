#!/bin/bash

NON_ESSENTIAL_BUILD="wget ca-certificates"
RUNTIME="python-minimal libpython-stdlib libgomp1 zlib1g"

# Build dependencies
apt-get update --yes
apt-get install --yes --no-install-recommends ${NON_ESSENTIAL_BUILD}

URL=https://github.com/voutcn/megahit/releases/download/v1.0.6/megahit_v1.0.6_LINUX_CPUONLY_x86_64-bin.tar.gz
mkdir /usr/local/megahit
wget ${URL} --quiet --output-document - \
	| tar xzf - --directory /usr/local/megahit --strip-components=1
ln -s /usr/local/megahit/megahit* /usr/local/bin


# Clean up dependencies
apt-get autoremove --purge --yes ${NON_ESSENTIAL_BUILD}
apt-get clean

# Install required files
apt-get install --yes --no-install-recommends ${RUNTIME}
rm -rf /var/lib/apt/lists/*
