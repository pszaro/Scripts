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

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# Download and install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
    echo "xcode not found, install..."
    xcode-select --install
fi

git clone http://github.com/pszaro/Scripts.git
cd Scripts
./go.sh getmygit
cd ../dotfiles
./run.sh i
./go.sh update
./go.sh defaults
./go.sh install:ctags
./go.sh install:brewpip
./go.sh install:software
./go.sh enable:callhome

cd ~/github-repos/mac-setup-playbook
ansible-playbook -i inventory --ask-become-pass main.yml



echo
echo
echo -=[ Finished bootstrap ]=-
echo
echo
