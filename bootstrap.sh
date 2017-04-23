#!/bin/bash
#
# Description: bootstrap script to initial multiple installs and updates using go
#
#

set -e

# Download and install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi
