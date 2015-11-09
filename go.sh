#!/bin/bash

# DESCRIPTION
# Executes the command line interface.

# USAGE
# ./run.sh OPTION

# SETTINGS
source ~/Scripts/settings.sh

# LIBRARY
source ~/Scripts/installers.sh #needed to know how to install based on type
source ~/Scripts/options.sh
source ~/Scripts/utlilties.sh
#source ~/Scripts/reinstallers.sh
#source ~/Scripts/uninstallers.sh
source ~/Scripts/verification.sh

# EXECUTION
while true; do
  if [[ $# == 0 ]]; then
    printf "\nUsage: run OPTION\n"
    printf "\nOSX Options:\n"
    printf "  Setup:\n"
    printf "    b:  Apply default system settings.\n"
    printf "    h:  Install Homebrew software.\n"
    printf "    g:  Install my git repos (if not installed) .\n"
    printf "    p:  Install necessary software.\n"
    printf "    v:  Verifies necessary software.\n"
    printf "  Manage:\n"
    printf "    i:  Turn Indexing Off.\n"
    printf "    o:  Turn Indexing On.\n"
    printf "  Maintenance:\n"
    printf "    d:  Clean Duplicates in Open With Selection.\n"
    printf "    q:  Quit/Exit.\n\n"
    read -p "Enter selection: " response
    printf "\n"
    process_option $response
  else
    process_option $1
  fi
done
