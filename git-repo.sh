#!/bin/bash

# DESCRIPTION
# Sets up and launches (if necessary) installed software.

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
  rm -f $HOME/.bash_profile
  install_git_project "git://github.com/pszaro/dotfiles.git" "dotfiles" "./run.sh i"
  source $HOME/.bashrc
fi
