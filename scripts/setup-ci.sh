#!/bin/sh
# For CI: configures SSH and installs binaries that I use to build my site.
# The binaries are statically-linked for Linux on x86_64

# no pipefail here since there are no pipes.
set -eux

# mirrored at https://seirdy.one/pb/binaries.tar.gz
rsync -WPv \
	-e "ssh -o KexAlgorithms=sntrup761x25519-sha512@openssh.com -o VerifyHostKeyDNS=yes" \
	deploy@seirdy.one:/var/www/pb/binaries.tar.gz .
mkdir -p ~/bin
tar xzf binaries.tar.gz -oC ~/bin
rm binaries.tar.gz
