#!/bin/bash
# Description: Applies system and application defaults.
#

# EXECUTION
printf "System - Disable boot sound effects\n"
#sudo nvram SystemAudioVolume=" "

printf "System - Enable Macbook Power Chime with Plugged in\n"
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true; open /System/Library/CoreServices/PowerChime.app &

printf "System - Reveal IP address, hostname, OS version, etc. when clicking the login window clock\n"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Checking if ~/Pictures/Screenshots exists
  if [[ ! -d "~/Pictures/Screenshots" ]]; then
    printf "~/Pictures/Screenshots does not exist, creating..."
    mkdir ~/Pictures/Screenshots
  fi
printf "System - Move Screeshot location to ~/Pictures/Screenshots\n"
defaults write com.apple.screencapture location ~/Pictures/Screenshots

printf "System - Disable automatic termination of inactive apps\n"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

printf "System - Expand save panel by default\n"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

printf "System - Disable the 'Are you sure you want to open this application?' dialog\n"
defaults write com.apple.LaunchServices LSQuarantine -bool false

printf "System - Speed Up Animations\n"
defaults write -g NSWindowResizeTime -float 0.003

printf "System - Disable animations when opening and closing windows\n"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

printf "System - Disable animations when opening a Quick Look window\n"
defaults write -g QLPanelAnimationDuration -float 0

printf "System - Make all animations faster that are used by Mission Control\n"
defaults write com.apple.dock expose-animation-duration -float 0.1

printf "System - Increase window resize speed for Cocoa applications\n"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

printf "System - Disable window resume system-wide\n"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

printf "System - Disable auto-correct\n"
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

printf "System - Disable smart quotes (not useful when writing code)\n"
#defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

printf "System - Disable smart dashes (not useful when writing code)\n"
#defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

printf "System - Require password immediately after sleep or screen saver begins\n"
#defaults write com.apple.screensaver askForPassword -int 1
#defaults write com.apple.screensaver askForPasswordDelay -int 0

printf "System - Avoid creating .DS_Store files on network volumes\n"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

printf "System - Avoid creating .DS_Store files on USB volumes\n"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

printf "System - Automatically restart if system freezes\n"
systemsetup -setrestartfreeze on

printf "System - Disable software updates\n"
#sudo softwareupdate --schedule off

printf "System - Disable Sudden Motion Sensor (not needed for SSD drives)\n"
sudo pmset -a sms 0

# Rename default boot disk name
  if [[ -d "/Volumes/Macintosh HD" ]]; then
     printf "Renaming boot disks:"
     /usr/sbin/diskutil rename "Macintosh HD" "OS X"
  fi

printf "Keyboard - Automatically illuminate built-in MacBook keyboard in low light\n"
defaults write com.apple.BezelServices kDim -bool true

printf "Keyboard - Turn off keyboard illumination when computer is not used for 5 minutes\n"
defaults write com.apple.BezelServices kDimTime -int 300

printf "Keyboard - Enable keyboard access for all controls\n"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

printf "Keyboard - Set a fast keyboard repeat rate\n"
defaults write NSGlobalDomain KeyRepeat -int 0

printf "Keyboard - Disable press-and-hold for keys in favor of key repeat\n"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

printf "Trackpad - Map bottom right corner to right-click\n"
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

printf "Trackpad - Enable tap to click for current user and the login screen\n"
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

printf "Trackpad - Use CONTROL (^) with scroll to zoom\n"
#defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
#defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

printf "Trackpad - Follow keyboard focus while zoomed in\n"
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

printf "Bluetooth - Increase sound quality for headphones/headsets\n"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

printf "Menu Bar - Show only Bluetooth and Airport\n"
#for domain in $HOME/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
#    defaults write "${domain}" dontAutoLoad -array "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
#  done

#  defaults write com.apple.systemuiserver menuExtras -array \
#      "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
#        "/System/Library/CoreServices/Menu Extras/AirPort.menu"

  printf "Dock - Remove all default app icons\n"
#  defaults write com.apple.dock persistent-apps -array

  printf "Dock - Automatically hide and show\n"
#  defaults write com.apple.dock autohide -bool true

  printf "Dock - Remove the auto-hiding delay\n"
#  defaults write com.apple.Dock autohide-delay -float 0

  printf "Dock - Don’t show Dashboard as a Space\n"
#  defaults write com.apple.dock "dashboard-in-overlay" -bool true

  printf "iCloud - Save to disk by default\n"
#  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  printf "Finder - Show the $HOME/Library folder\n"
  chflags nohidden $HOME/Library

  printf "Finder - Show hidden files\n"
#  defaults write com.apple.finder AppleShowAllFiles -bool true

  printf "Finder - Show filename extensions\n"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  printf "Finder - Disable the warning when changing a file extension\n"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  printf "Finder - Show path bar\n"
  defaults write com.apple.finder ShowPathbar -bool true

  printf "Finder - Show status bar\n"
  defaults write com.apple.finder ShowStatusBar -bool true

  printf "Finder - Display full POSIX path as window title\n"
#  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  printf "Finder - Use list view in all Finder windows\n"
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

  printf "Finder - Allow quitting via COMMAND+Q -- Doing so will also hide desktop icons\n"
#  defaults write com.apple.finder QuitMenuItem -bool true

  printf "Finder - Disable the warning before emptying the Trash\n"
#  defaults write com.apple.finder WarnOnEmptyTrash -bool false

  printf "Finder - Allow text selection in Quick Look\n"
  defaults write com.apple.finder QLEnableTextSelection -bool true

  printf "Safari - Set home page to 'about:blank' for faster loading\n"
  defaults write com.apple.Safari HomePage -string "about:blank"

  printf "Safari - Hide bookmarks bar\n"
  #defaults write com.apple.Safari ShowFavoritesBar -bool false

  printf "Safari - Use Contains instead of Starts With in search banners\n"
  defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

  printf "Safari - Enable debug menu\n"
  #defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari IncludeInternalDebugMenu 1

  printf "Safari - Enable the Develop menu and the Web Inspector\n"
  #defaults write com.apple.Safari IncludeDevelopMenu -bool true
  #defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  #defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

  printf "Safari - Add a context menu item for showing the Web Inspector in web views\n"
  #defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  printf "Safari - Disable sending search queries to Apple.\n"
  defaults write com.apple.Safari UniversalSearchEnabled -bool false

  printf "Chrome - Prevent native print dialog, use system dialog instead\n"
  defaults write com.google.Chrome DisablePrintPreview -boolean true

  printf "Photos - Disable Photos show up when devices are plugged (OS X 10.11 and earlier)"
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
  
  printf "Mail - Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>'\n"
  defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

  printf "Mail - Disable send animation\n"
  defaults write com.apple.mail DisableSendAnimations -bool true

  printf "Mail - Disable reply animation\n"
  defaults write com.apple.mail DisableReplyAnimations -bool true

  printf "Mail - Enable COMMAND+ENTER to send mail\n"
  defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

  printf "Address Book - Enable debug menu\n"
  #defaults write com.apple.addressbook ABShowDebugMenu -bool true

  printf "iCal - Enable debug menu\n"
  #defaults write com.apple.iCal IncludeDebugMenu -bool true

  printf "TextEdit - Use plain text mode for new documents\n"
  defaults write com.apple.TextEdit RichText -int 0

  printf "TextEdit - Open and save files as UTF-8 encoding\n"
  defaults write com.apple.TextEdit PlainTextEncoding -int 4
  defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

  printf "Disk Utility - Enable debug menu\n"
  #defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
  #defaults write com.apple.DiskUtility advanced-image-options -bool true

  printf "Time Machine - Prevent prompting to use new hard drives as backup volume\n"
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

  printf "Printer - Expand print panel by default\n"
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

  printf "Printer - Automatically quit printer app once the print jobs complete\n"
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  printf "App Store - Enable the WebKit Developer Tools in the Mac App Store\n"
  #defaults write com.apple.appstore WebKitDeveloperExtras -bool true

  printf "App Store - Enable Debug Menu in the Mac App Store\n"
  defaults write com.apple.appstore ShowDebugMenu -bool true
  
  printf "Overall - SystemUIServer relaunch"
  killall SystemUIServer

