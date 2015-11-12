#!/bin/bash

# DESCRIPTION
# Defines command line prompt options.

# Process option selection.
# Parameters:
# $1 = The option to process.
process_option() {
  case $1 in
    'b')
     ~/Scripts/defaults.sh
     break;;
    'h')
      ~/Scripts/homebrew.sh
      break;;
    'hr')
      echo "Discovering brew packages installed and will remove..."
      for p in `brew list`; do brew remove $p; done
      echo "Discovering pip packages installed and will remove..."
      for p in `pip list`; do pip uninstall $p; done
      break;;
   'g')
      ~/Scripts/git-repo.sh
      break;;  
   'p')  
     ~/Scripts/applications.sh
      break;; 
    'pu')
     ~/Scripts/pip_upgrade.sh
      break;;
    'v')
     ~/Scripts/verification.sh
      break;;   
    'i')
     ~/Scripts/turn-indexing-off.sh  
     break;;
    'o')
     ~/Scripts/turn-indexing-on.sh
     break;;
     'd')
     ./Clean-Duplicates-Open-With.sh
     break;;
    'q')
      break;;
    *)
      printf "ERROR: Invalid option.\n"
      break;;
  esac
}
export -f process_option
