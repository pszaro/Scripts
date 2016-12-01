#!/bin/bash
#
# Description: Sets up and launches (if necessary) installed software.
#

# Bash
#sudo bash -c "printf '/usr/local/bin/bash\n' >> /etc/shells"

# Bash Completion
#chsh -s /usr/local/bin/bash

# git
echo "Checking git repos..."
if [[ -d ~/dotfiles ]]; then 
  echo
  echo "Looks like my .files GIT repo is installed...."
  echo
else
  [ -f $HOME/.bash_profile ] && rm -f $HOME/.bash_profile
  install_git_project "git://github.com/pszaro/dotfiles.git" "dotfiles" "./run.sh i"
  mv dotfiles ../
  if [ $? = 0 ]; then
    echo "Git Repo dotfiles moved to $HOME/dotfiles"
  fi
  [ -f $HOME/.bashrc ] && source $HOME/.bashrc
fi
