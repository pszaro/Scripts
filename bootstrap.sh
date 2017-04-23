#!/bin/bash
#
# Description: bootstrap script to initial multiple installs and updates using go
#
#

set -e

echo
echo
echo -=[ Starting bootstrap... ]=-
echo
echo

# Download and install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi

git clone http://github.com/pszaro/Scripts.git
cd scripts
./go.sh getmygit
cd ../dotfiles
./run.sh i
./go.sh update
./go.sh defaults
./go.sh install:ctags
./go.sh install:brewpip
./go.sh install:software
./go.sh enable:callhome



echo
echo
echo -=[ Finished bootstrap ]=-
echo
echo
