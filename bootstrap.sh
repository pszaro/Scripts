#!/bin/bash
#
# Description: bootstrap script to initial multiple installs and updates using go on a clean macOS install
#
# curl -O https://raw.githubusercontent.com/pszaro/Scripts/master/bootstrap.sh
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

echo
echo -=[ Clone my Scripts git repo ... ]=-
echo
git clone http://github.com/pszaro/Scripts.git
cd ~/Scripts

echo
echo -=[ Clone all my git repos ... ]=-
echo
./go.sh getmygit

echo
echo -=[ Check and Install for macOS updates ... ]=-
echo
./go.sh update

echo
echo -=[ Setting macOS personal defaults ... ]=-
echo
./go.sh defaults

echo
echo -=[ Installing newer ctags ... ]=-
echo
./go.sh install:ctags

echo
echo -=[ Installing brew & pip applications ... ]=-
echo
./go.sh install:brewpip

echo
echo -=[ Installing 3rd Party software ... ]=-
echo
./go.sh install:software

echo
echo -=[ Disabling Apple callhome... ]=-
echo
./go.sh enable:callhome

echo
echo -=[ Executing dotfiles... ]=-
echo
cd ~/dotfiles
./run.sh i

echo
echo -=[ Executing Ansible mac-setup-playbook... ]=-
echo
cd ~/git-repos/mac-setup-playbook
ansible-playbook -i inventory --ask-become-pass main.yml



echo
echo
echo -=[ Finished bootstrap ]=-
echo
echo
