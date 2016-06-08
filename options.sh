#!/bin/bash
#
# Description: Defines command line prompt options.
#

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
    'dd')
    ~/Scripts/list_volumes.sh
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
     's')
     defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}' ; killall Dock 
     break;;
     'x')
     find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'
     break;;
     'w')
     SSID=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'`
     SSIDPW=`security find-generic-password -wa $SSID`
     echo "Current SSID: $SSID - $SSIDPW"
     echo
     break;;
    'q')
      break;;
    *)
      printf "ERROR: Invalid option.\n"
      break;;
  esac
}
export -f process_option
