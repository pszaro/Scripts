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
    printf "    b:   Apply default system settings\n"
    printf "    g:   Install my git repos (if not installed)\n"
    printf "    h:   Install Homebrew|pip software\n"
    printf "    hr:  Remove ALL Homebrew|pip software\n"
    printf "    pu:  Update pip software\n"
    printf "    p:   Install necessary software\n"
    printf "    v:   Verifies necessary software\n"
    printf "  Manage:\n"
    printf "    dd:  Display Mounted Volumes\n"
    printf "    i:  Turn Indexing Off\n"
    printf "    o:  Turn Indexing On\n"
    printf "    s:  Create Space In Dock\n"
    printf "  Maintenance:\n"
    printf "    q:  Quit/Exit\n\n"
    read -p "Enter selection: " response
    printf "\n"
    process_option $response
  else
    process_option $1
  fi
done
