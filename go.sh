#!/bin/sh
#
# Description: Main Menu
#

# DESCRIPTION
# Executes the command line interface.

# USAGE
# ./go.sh OPTION

#--------------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------------

datestamp=`date +"%Y%m%d"`
PIPLOC=/usr/local/Cellar/python/2.7.14_2/bin

#--------------------------------------------------------------------
# Parameters
#--------------------------------------------------------------------
function=$1
firstParameter=$2
secondParameter=$3
allParameters=${@:2}

#--------------------------------------------------------------------
# Colors
#--------------------------------------------------------------------
GREEN='\033[0;32m'
GRAY='\033[0;37m'
LIGHTBLUE='\033[1;34m'
LIGHTGREEN='\033[1;32m'
WHITEBOLD='\033[1;37m'
RED='\033[1;31m'
NC='\033[0m' # No Color

#--------------------------------------------------------------------
# Utilities
#--------------------------------------------------------------------

# Is the user running commands in sudo?
IS_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)

#--------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------

xcode_install () 

{

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Installing the Xcode command line tools on 10.9.x or higher

osx_vers=$(sw_vers -productVersion | awk -F "." '{print $2}')
cmd_line_tools_temp_file="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"

# Installing the latest Xcode command line tools on 10.9.x or higher
echo " Scanning for OSX Version and Xcode command line tools version..."

if [[ "${osx_vers}" -ge 9 ]]; then

  # Create the placeholder file which is checked by the softwareupdate tool
  # before allowing the installation of the Xcode command line tools.

  touch "${cmd_line_tools_temp_file}"

  # Find the last listed update in the Software Update feed with "Command Line Tools" in the name

  cmd_line_tools=$(softwareupdate -l | awk '/\*\ Command Line Tools/ { $1=$1;print }' | tail -1 | sed 's/^[[ \t]]*//;s/[[ \t]]*$//;s/*//' | cut -c 2-)

  #Install the command line tools

  softwareupdate -i "${cmd_line_tools}" -v

  # Remove the temp file

  if [[ -f "${cmd_line_tools_temp_file}" ]]; then
    rm -v "${cmd_line_tools_temp_file}"
  fi
fi

# End of Xcode command line tools check/install

#Remove All Unavailable Simulators
xcrun simctl delete unavailable

}

#--------------------------------------------------------------------
# go script commands list - all commands
#--------------------------------------------------------------------

if [[ "$function" == "list" || "$function" == "help" || "$function" == "" ]]; then

    printf "\n${WHITEBOLD}Setup & Config: (go list:setup) \n"
    printf "${LIGHTBLUE}go update${GRAY} : Install OS X software updates\n"
    printf "${LIGHTBLUE}go defaults${GRAY} : Apply default system settings\n"
    printf "${LIGHTBLUE}go install:ctags${GRAY} : Install ctags 5.8\n"
    printf "${LIGHTBLUE}go install:brewpip${GRAY} : Install ALL Homebrew & PIP software\n"
    printf "${LIGHTBLUE}go remove:brewpip${GRAY} : Remove ALL Homebrew & PIP software\n"
    printf "${LIGHTBLUE}go update:brewpip${GRAY} : Update ALL Homebrew & PIP software\n"
    printf "${LIGHTBLUE}go install:software${GRAY} : Install necessary software\n"
    printf "${LIGHTBLUE}go disable:callhome${GRAY} : Disable Apple Call Homes (custom)\n" 
    printf "${LIGHTBLUE}go enable:callhome${GRAY} : Enable Apple Call Homes (stock)\n" 
    printf "${LIGHTBLUE}go refresh:hosts${GRAY} : Refresh /etc/hosts file \n" 


    printf "\n${WHITEBOLD}General Utilities: (go list:general) \n"
    printf "${LIGHTBLUE}go lock${GRAY} : Lock\n"
    printf "${LIGHTBLUE}go restart${GRAY} : Restart OS X\n"
    printf "${LIGHTBLUE}go sleep${GRAY} : Sleep mode\n"
    printf "${LIGHTBLUE}go shutdown${GRAY} : Shutdown\n"
    printf "${LIGHTBLUE}go time${GRAY} : Show clock at top right position in Terminal/iTerm\n"
    printf "${LIGHTBLUE}go screensaver${GRAY} : Start screensaver\n"
    printf "${LIGHTBLUE}go folders:list${GRAY} : List folders in current directory with their current size\n"
    printf "${LIGHTBLUE}go folder:size${GRAY} : Calculate current folder size\n"
    printf "${LIGHTBLUE}go folders:remove-empty${GRAY} : Remove empty subdirectories\n"
    printf "${LIGHTBLUE}go apps:close-all${GRAY} : Close all opened apps\n"
    printf "${LIGHTBLUE}go apps:app-store${GRAY} : Get list of installed apps from App Store\n"
    printf "${LIGHTBLUE}go display:users${GRAY} : Display defined local accounts\n"
    printf "${LIGHTBLUE}go display-all${GRAY} : Display mounted volumes and disks\n"
    printf "${LIGHTBLUE}go eject-all${GRAY} : Eject all mounted volumes and disks\n"
    printf "${LIGHTBLUE}go battery:status${GRAY} : Get battery information\n"
    printf "${LIGHTBLUE}go info${GRAY} : Get OS X version information\n"
    printf "${LIGHTBLUE}go find:text ${LIGHTGREEN}X${GRAY} : Find exact phrase recursively inside directory - ${LIGHTGREEN}X = Text string\n"
    printf "${LIGHTBLUE}go find:biggest-files ${GRAY} : Find biggest files inside directory\n"
    printf "${LIGHTBLUE}go find:biggest-directories ${GRAY} : Find biggest directories inside directory\n"
    printf "${LIGHTBLUE}go zip:extract ${LIGHTGREEN}X${GRAY} : Extract Zip file to current folder - ${LIGHTGREEN}X = Zip file to extract\n"
    printf "${LIGHTBLUE}go gzip:compress ${LIGHTGREEN}X${GRAY} : Compress current file using Gzip - ${LIGHTGREEN}X = File to compress\n"
    printf "${LIGHTBLUE}go gzip:extract ${LIGHTGREEN}X${GRAY} : Extract Gzip file to current folder - ${LIGHTGREEN}X = Gzip file to extract\n"
    printf "${LIGHTBLUE}go tar:compress ${LIGHTGREEN}X${GRAY} : Compress X file/directory using tar with progress indicator - ${LIGHTGREEN}X = File or directory\n"
    printf "${LIGHTBLUE}go tar:extract ${LIGHTGREEN}X${GRAY} : Extract tar file to current folder - ${LIGHTGREEN}X = Tar file to extract\n"
    printf "${LIGHTBLUE}go getwifipw${GRAY} : Determine SSID & Password\n"
    printf "${LIGHTBLUE}go spacedock${GRAY} : Create Space In Dock\n"
    printf "${LIGHTBLUE}go smallspacedock${GRAY} : Create Small Space In Dock\n"
    printf "${LIGHTBLUE}go turnindexingoff${GRAY} : Turn Indexing Off\n"
    printf "${LIGHTBLUE}go turnindexingon${GRAY} : Turn Indexing On\n"
    printf "${LIGHTBLUE}go airplane-mode:status${GRAY} : Check Airplane Status\n"
    printf "${LIGHTBLUE}go airplane-mode:on${GRAY} : Enable Airplane Mode\n"
    printf "${LIGHTBLUE}go airplane-mode:off${GRAY} : Disable Airplane Mode\n"


    printf "\n${WHITEBOLD}Time Machine: (go list:tm) \n"
    printf "${LIGHTBLUE}go tmenable${GRAY} : Enable Local Time Machine Backups\n"
    printf "${LIGHTBLUE}go tmdisable${GRAY} : Disable Local Time Machine Backups\n"
    printf "${LIGHTBLUE}go tmdisablebattery${GRAY} : Disable Local Time Machine Backups While on Battery\n"
    printf "${LIGHTBLUE}go tmlatest${GRAY} : Display Latest Time Machine Backup\n"
    printf "${LIGHTBLUE}go tmlist${GRAY} : Display Full List of Time Machine Backups\n"


    printf "\n${WHITEBOLD}Search Utilities: (go list:search) \n"
    printf "${LIGHTBLUE}go find:recent ${LIGHTGREEN}X${GRAY} : Find files modified in the last N minutes - ${LIGHTGREEN}X = number of minutes \n"
    printf "${LIGHTBLUE}go search:replace ${LIGHTGREEN}X${GRAY} : Search and replace string in file - ${LIGHTGREEN}X = File to perform the search and replace operation\n"


    printf "\n${WHITEBOLD}Network Utilities: (go list:network) \n"
    printf "${LIGHTBLUE}go speedtest${GRAY} : Internet connection speed test \n"
    printf "${LIGHTBLUE}go ports${GRAY} : List of used ports \n"
    printf "${LIGHTBLUE}go ip:local${GRAY} : Get local IP address \n"
    printf "${LIGHTBLUE}go ip:public${GRAY} : Get public IP address \n"
    printf "${LIGHTBLUE}go ip:mac${GRAY} : Get MAC Address \n"


    printf "\n${WHITEBOLD}SSH Utilities: (go list:ssh) \n"
    printf "${LIGHTBLUE}go ssh:download-file ${LIGHTGREEN}X${GRAY} : Download file from remote server through SSH - X = Path of the remote file to download \n"
    printf "${LIGHTBLUE}go ssh:download-folder ${LIGHTGREEN}X${GRAY} : Download entire folder from remote server through SSH - X = Path of the remote folder to download \n"
    printf "${LIGHTBLUE}go ssh:download-database ${LIGHTGREEN}X${GRAY} : Download database from remote server through SSH - X = Name of the database to download \n"
    printf "${LIGHTBLUE}go ssh:sync:local ${LIGHTGREEN}X${GRAY} : Sync local folder with remote folder using rsync through SSH (download remote folder to local folder)\n"
    printf "${LIGHTBLUE}go ssh:sync:remote ${LIGHTGREEN}X${GRAY} : Path of the remote folder to sync from local folder (upload local folder to remote folder) \n"
    printf "${LIGHTBLUE}go ssh:upload ${LIGHTGREEN}X${GRAY} : Upload file to remote server through SSH - X = Path of the file to upload to the remote server \n"
    printf "${LIGHTBLUE}go ssh:public-key ${LIGHTGREEN}X${GRAY} : Get public SSH key for local gohine \n"
    printf "${LIGHTBLUE}go ssh:list ${LIGHTGREEN}X${GRAY} : List all the saved SSH credentials \n"


    printf "\n${WHITEBOLD}Web Development Utilities: (go list:dev) \n"
    printf "${LIGHTBLUE}go dev:monitor ${LIGHTGREEN}X${GRAY} : Monitor file changes (for example: log file) - X = File to monitor \n"
    printf "${LIGHTBLUE}go dev:compass:compile ${LIGHTGREEN}X${GRAY} : Compile current folder using compass \n"
    printf "${LIGHTBLUE}go dev:optimize-images${GRAY} : Optimize all images in current directory and subdirectories \n"
    printf "${LIGHTBLUE}go dev:css:convert-to-scss${GRAY} : Convert CSS file to SCSS \n"


    printf "\n${WHITEBOLD}Performance and maintenance Utilities: (go list:performance) \n"
    printf "${LIGHTBLUE}go system${GRAY} : Show system information to review go performance \n"
    printf "${LIGHTBLUE}go memory${GRAY} : See memory usage sorted by memory consumption \n"
    printf "${LIGHTBLUE}go trash:empty${GRAY} : Empty trash\n"
    printf "${LIGHTBLUE}go trash:size${GRAY} : Calculate trash size\n"


    printf "\n${WHITEBOLD}iTerm / Terminal Utilities: (go list:terminal) \n"
    printf "${LIGHTBLUE}go iterm:tab-title${GRAY} : Set title to current iTerm tab \n"


    printf "\n${WHITEBOLD}GIT Utilities: (go list:git) \n"
    printf "${LIGHTBLUE}go getmygit${GRAY} : Install my git repos (if not installed) \n"
    printf "${LIGHTBLUE}go git:config${GRAY} : Display local Git configuration \n"
    printf "${LIGHTBLUE}go git:open${GRAY} : Open current repository on Github \n"
    printf "${LIGHTBLUE}go git:create:branch${GRAY} : Create branch based on current branch \n"
    printf "${LIGHTBLUE}go git:branches:date${GRAY} : Get last update date for all branches in current project \n"
    printf "${LIGHTBLUE}go git:undo-commit${GRAY} : Undo latest commit \n"
    printf "${LIGHTBLUE}go git:log${GRAY} : See latest commits IDs and titles for current branch \n"
    printf "${LIGHTBLUE}go git:branch${GRAY} : See all branches \n"
    printf "${LIGHTBLUE}go git:branch:rename${GRAY} : Rename GIT branch \n"
    printf "${LIGHTBLUE}go git:branch:remove-local${GRAY} : Remove local GIT branch \n"
    printf "${LIGHTBLUE}go git:branch:remove-remote${GRAY} : Remove local and remote GIT branch \n"
    printf "${LIGHTBLUE}go git:remove${GRAY} : Remove GIT from current project \n"
    printf "${LIGHTBLUE}go git:settings${GRAY} : Check GIT settings \n"
    printf "${LIGHTBLUE}go git:add-removed${GRAY} : Add removed files to staged files \n"
    printf "${LIGHTBLUE}go git:size${GRAY} : Get size for current GIT repository \n"


    printf "\n${WHITEBOLD}Web Utilities: (go list:web) \n"
    printf "${LIGHTBLUE}go web:download-images${GRAY} : Download all images from website to current directory \n"


#--------------------------------------------------------------------
# go script commands list - Setup & Config commands
#--------------------------------------------------------------------

elif [ "$function" == "list:setup" ]; then

    printf "\n${WHITEBOLD}Setup & Config: \n"

    printf "${LIGHTBLUE}go update${GRAY} : Install OS X software updates\n"
    printf "${LIGHTBLUE}go defaults${GRAY} : Apply default system settings\n"
    printf "${LIGHTBLUE}go install:ctags${GRAY} : Install ctags 5.8\n"
    printf "${LIGHTBLUE}go install:brewpip${GRAY} : Install ALL Homebrew & PIP software\n"
    printf "${LIGHTBLUE}go remove:brewpip${GRAY} : Remove ALL Homebrew & PIP software\n"
    printf "${LIGHTBLUE}go update:brewpip${GRAY} : Update ALL Homebrew & PIP software\n"
    printf "${LIGHTBLUE}go install:software${GRAY} : Install necessary software\n"
    printf "${LIGHTBLUE}go disable:callhome${GRAY} : Disable Apple Call Homes (custom)\n" 
    printf "${LIGHTBLUE}go enable:callhome${GRAY} : Enable Apple Call Homes (stock)\n" 
    printf "${LIGHTBLUE}go refresh:hosts${GRAY} : Refresh /etc/hosts file \n" 


#--------------------------------------------------------------------
# go script commands list - general commands
#--------------------------------------------------------------------

elif [ "$function" == "list:general" ]; then

    printf "\n\n${WHITEBOLD}General Utilities: \n"

    printf "${LIGHTBLUE}go lock${GRAY} : Lock\n"
    printf "${LIGHTBLUE}go restart${GRAY} : Restart OS X\n"
    printf "${LIGHTBLUE}go sleep${GRAY} : Sleep mode\n"
    printf "${LIGHTBLUE}go shutdown${GRAY} : Shutdown\n"
    printf "${LIGHTBLUE}go time${GRAY} : Show clock at top right position in Terminal/iTerm\n"
    printf "${LIGHTBLUE}go screensaver${GRAY} : Start screensaver\n"
    printf "${LIGHTBLUE}go folders:list${GRAY} : List folders in current directory with their current size\n"
    printf "${LIGHTBLUE}go folder:size${GRAY} : Calculate current folder size\n"
    printf "${LIGHTBLUE}go folders:remove-empty${GRAY} : Remove empty subdirectories\n"
    printf "${LIGHTBLUE}go apps:close-all${GRAY} : Close all opened apps\n"
    printf "${LIGHTBLUE}go apps:app-store${GRAY} : Get list of installed apps from App Store\n"
    printf "${LIGHTBLUE}go display:users${GRAY} : Display defined local accounts\n"
    printf "${LIGHTBLUE}go display-all${GRAY} : Display mounted volumes and disks\n"
    printf "${LIGHTBLUE}go eject-all${GRAY} : Eject all mounted volumes and disks\n"
    printf "${LIGHTBLUE}go battery:status${GRAY} : Get battery information\n"
    printf "${LIGHTBLUE}go info${GRAY} : Get OS X version information\n"
    printf "${LIGHTBLUE}go find:text ${LIGHTGREEN}X${GRAY} : Find exact phrase recursively inside directory - ${LIGHTGREEN}X = Text string\n"
    printf "${LIGHTBLUE}go find:biggest-files ${LIGHTGREEN}X${GRAY} : Find biggest files inside directory\n"
    printf "${LIGHTBLUE}go find:duplicated ${GRAY} : Find duplicated files\n"
    printf "${LIGHTBLUE}go find:biggest-directories ${LIGHTGREEN}X${GRAY} : Find biggest directories inside directory\n"
    printf "${LIGHTBLUE}go zip:extract ${LIGHTGREEN}X${GRAY} : Extract Zip file to current folder - ${LIGHTGREEN}X = Zip file to extract\n"
    printf "${LIGHTBLUE}go gzip:compress ${LIGHTGREEN}X${GRAY} : Compress current file using Gzip - ${LIGHTGREEN}X = File to compress\n"
    printf "${LIGHTBLUE}go gzip:extract ${LIGHTGREEN}X${GRAY} : Extract Gzip file to current folder - ${LIGHTGREEN}X = Gzip file to extract\n"
    printf "${LIGHTBLUE}go tar:compress ${LIGHTGREEN}X${GRAY} : Compress X file/directory using tar with progress indicator - ${LIGHTGREEN}X = File or directory\n"
    printf "${LIGHTBLUE}go tar:extract ${LIGHTGREEN}X${GRAY} : Extract tar file to current folder - ${LIGHTGREEN}X = Tar file to extract\n"
    printf "${LIGHTBLUE}go getwifipw${GRAY} : Determine SSID & Password\n"
    printf "${LIGHTBLUE}go spacedock${GRAY} : Create Space In Dock\n"
    printf "${LIGHTBLUE}go smallspacedock${GRAY} : Create Small Space In Dock\n"
    printf "${LIGHTBLUE}go turnindexingoff${GRAY} : Turn Indexing Off\n"
    printf "${LIGHTBLUE}go turnindexingon${GRAY} : Turn Indexing On\n"
    printf "${LIGHTBLUE}go airplane-mode:status${GRAY} : Check Airplane Status\n"
    printf "${LIGHTBLUE}go airplane-mode:on${GRAY} : Enable Airplane Mode\n"
    printf "${LIGHTBLUE}go airplane-mode:off${GRAY} : Disable Airplane Mode\n"
    printf "${LIGHTBLUE}go tmenable${GRAY} : Enable Local Time Machine Backups\n"
    printf "${LIGHTBLUE}go tmdisable${GRAY} : Disable Local Time Machine Backups\n"
    printf "${LIGHTBLUE}go tmdisablebattery${GRAY} : Disable Local Time Machine Backups While on Battery\n"
    printf "${LIGHTBLUE}go tmlatest${GRAY} : Display Latest Time Machine Backup\n"
    printf "${LIGHTBLUE}go tmlist${GRAY} : Display Full List of Time Machine Backups\n"
    
    
#--------------------------------------------------------------------
# go script commands list - time machine
#--------------------------------------------------------------------

elif [ "$function" == "list:tm" ]; then
    
    printf "\n${WHITEBOLD}Time Machine: (go list:tm) \n"

    printf "${LIGHTBLUE}go tmenable${GRAY} : Enable Local Time Machine Backups\n"
    printf "${LIGHTBLUE}go tmdisable${GRAY} : Disable Local Time Machine Backups\n"
    printf "${LIGHTBLUE}go tmdisablebattery${GRAY} : Disable Local Time Machine Backups While on Battery\n"
    printf "${LIGHTBLUE}go tmlatest${GRAY} : Display Latest Time Machine Backup\n"
    printf "${LIGHTBLUE}go tmlist${GRAY} : Display Full List of Time Machine Backups\n"

    echo
    [ -d /Volumes/MobileBackups ] && printf "***FYI*** Local Time Machine Snapshots Exist (/Volumes/MobileBackups)\n"


#--------------------------------------------------------------------
# go script commands list - search commands
#--------------------------------------------------------------------

elif [ "$function" == "list:search" ]; then

    printf "\n${WHITEBOLD}Search Utilities: \n"
    
    printf "${LIGHTBLUE}go find:recent ${LIGHTGREEN}X${GRAY} : Find files modified in the last N minutes - ${LIGHTGREEN}X = number of minutes \n"
    printf "${LIGHTBLUE}go find:duplicated ${GRAY} : Find duplicated files\n"
    printf "${LIGHTBLUE}go search:replace ${LIGHTGREEN}X${GRAY} : Search and replace string in file - ${LIGHTGREEN}X = File to perform the search and replace operation\n"


#--------------------------------------------------------------------
# go script commands list - network commands
#--------------------------------------------------------------------

elif [ "$function" == "list:network" ]; then

    printf "\n${WHITEBOLD}Network Utilities: \n"
    
    printf "${LIGHTBLUE}go speedtest${GRAY} : Internet connection speed test \n"
    printf "${LIGHTBLUE}go ports${GRAY} : List of used ports \n"
    printf "${LIGHTBLUE}go ip:local${GRAY} : Get local IP address \n"
    printf "${LIGHTBLUE}go ip:public${GRAY} : Get public IP address \n"
    printf "${LIGHTBLUE}go ip:mac${GRAY} : Get MAC Address \n"


#--------------------------------------------------------------------
# go script commands list - SSH commands
#--------------------------------------------------------------------

elif [ "$function" == "list:ssh" ]; then

    printf "\n${WHITEBOLD}SSH Utilities: \n"
    
    printf "${LIGHTBLUE}go ssh:download-file ${LIGHTGREEN}X${GRAY} : Download file from remote server through SSH - X = Path of the remote file to download \n"
    printf "${LIGHTBLUE}go ssh:download-folder ${LIGHTGREEN}X${GRAY} : Download entire folder from remote server through SSH - X = Path of the remote folder to download \n"
    printf "${LIGHTBLUE}go ssh:download-database ${LIGHTGREEN}X${GRAY} : Download database from remote server through SSH - X = Name of the database to download \n"
    printf "${LIGHTBLUE}go ssh:sync:local ${LIGHTGREEN}X${GRAY} : Sync local folder with remote folder using rsync through SSH (download remote folder to local folder)\n"
    printf "${LIGHTBLUE}go ssh:sync:remote ${LIGHTGREEN}X${GRAY} : Path of the remote folder to sync from local folder (upload local folder to remote folder) \n"
    printf "${LIGHTBLUE}go ssh:upload ${LIGHTGREEN}X${GRAY} : Upload file to remote server through SSH - X = Path of the file to upload to the remote server \n"
    printf "${LIGHTBLUE}go ssh:public-key${GRAY} : Copy SSH Public Key \n"
    printf "${LIGHTBLUE}go ssh:list ${LIGHTGREEN}X${GRAY} : List all the saved SSH credentials \n"


#--------------------------------------------------------------------
# go script commands list - web development commands
#--------------------------------------------------------------------

elif [ "$function" == "list:dev" ]; then

    printf "\n${WHITEBOLD}Web Development Utilities: \n"
    
    printf "${LIGHTBLUE}go monitor ${LIGHTGREEN}X${GRAY} : Monitor file changes (for example: log file) - X = File to monitor \n"
    printf "${LIGHTBLUE}go compass:compile ${LIGHTGREEN}X${GRAY} : Compile current folder using compass"
    printf "${LIGHTBLUE}go dev:optimize-images${GRAY} : Optimize all images in current directory and subdirectories \n"
    printf "${LIGHTBLUE}go dev:css:convert-to-scss${GRAY} : Convert CSS file to SCSS \n"


#--------------------------------------------------------------------
# go script commands list - performance commands
#--------------------------------------------------------------------

elif [ "$function" == "list:performance" ]; then

    printf "\n${WHITEBOLD}Performance and maintenance Utilities: \n"
    
    printf "${LIGHTBLUE}go system${GRAY} : Show system information to review go performance \n"
    printf "${LIGHTBLUE}go memory${GRAY} : See memory usage sorted by memory consumption \n"
    printf "${LIGHTBLUE}go trash:empty${GRAY} : Empty trash\n"
    printf "${LIGHTBLUE}go trash:size${GRAY} : Calculate trash size\n"


#--------------------------------------------------------------------
# go script commands list - terminal commands
#--------------------------------------------------------------------

elif [ "$function" == "list:terminal" ]; then

    printf "\n${WHITEBOLD}iTerm / Terminal Utilities: \n"
    
    printf "${LIGHTBLUE}go iterm:tab-title${GRAY} : Set title to current iTerm tab \n"


#--------------------------------------------------------------------
# go script commands list - GIT commands
#--------------------------------------------------------------------

elif [ "$function" == "list:git" ]; then

    printf "\n${WHITEBOLD}GIT Utilities: \n"
    
    printf "${LIGHTBLUE}go getmygit${GRAY} : Install my git repos (if not installed) \n"
    printf "${LIGHTBLUE}go git:config${GRAY} : Display local Git configuration \n"
    printf "${LIGHTBLUE}go git:open${GRAY} : Open current repository on Github \n"
    printf "${LIGHTBLUE}go git:create:branch${GRAY} : Create branch based on current branch \n"
    printf "${LIGHTBLUE}go git:branches${GtRAY}: Get last update date for all branches in current project \n"
    printf "${LIGHTBLUE}go git:undo-commit${GRAY} : Undo latest commit \n"
    printf "${LIGHTBLUE}go git:log${GRAY} : See latest commits IDs and titles for current branch \n"
    printf "${LIGHTBLUE}go git:branch${GRAY} : See all branches \n"
    printf "${LIGHTBLUE}go git:branch:rename${GRAY} : Rename GIT branch \n"
    printf "${LIGHTBLUE}go git:branch:remove-local${GRAY} : Remove local GIT branch \n"
    printf "${LIGHTBLUE}go git:branch:remove-remote${GRAY} : Remove local and remote GIT branch \n"
    printf "${LIGHTBLUE}go git:remove${GRAY} : Remove GIT from current project \n"
    printf "${LIGHTBLUE}go git:settings${GRAY} : Check GIT settings \n"
    printf "${LIGHTBLUE}go git:add-removed${GRAY} : Add removed files to staged files \n"
    printf "${LIGHTBLUE}go git:size${GRAY} : Get size for current GIT repository \n"


#--------------------------------------------------------------------
# go script commands list - web commands
#--------------------------------------------------------------------

elif [ "$function" == "list:web" ]; then

    printf "\n${WHITEBOLD}Web Utilities: \n"
    
    printf "${LIGHTBLUE}go web:download-images${GRAY} : Download all images from website to current directory \n"


#--------------------------------------------------------------------
# General Utilities
#--------------------------------------------------------------------
elif [ "$function" == "defaults" ]; then

# Applies system and application defaults

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# EXECUTION
printf "System - Disable boot sound effects\n"
#sudo nvram SystemAudioVolume=" "

printf "System - Enable boot sound effects\n"
# Disabled on 2016 & Later MBP models
sudo nvram BootAudio=%01

printf "System - Enable Macbook Power Chime with Plugged in\n"
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true; open /System/Library/CoreServices/PowerChime.app &

printf "System - Reveal IP address, hostname, OS version, etc. when clicking the login window clock\n"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Checking if ~/Pictures/Screenshots exists
if [[ ! -d "~/Pictures/Screenshots" ]]; then
  echo "~/Pictures/Screenshots does not exist, creating..."
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
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

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

printf "System - Enable the firewall\n"
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

printf "System - Enable logging\n"
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on

printf "System - Enable stealth mode\n"
# Computer hackers scan networks so they can attempt to identify computers to attack. You can prevent your computer from responding to some of these scans by using stealth mode. When stealth mode is enabled, your computer does not respond to ICMP ping requests, and does not answer to connection attempts from a closed TCP or UDP port. This makes it more difficult for attackers to find your computer.
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

printf "System - Disable Captive Portal assistant utility\n"
# An attacker could trigger the utility and direct a Mac to a site with malware without user interaction, so it's best to disable this feature and log in to captive portals using your regular Web browser, provided you have first disable any custom dns and/or proxy settings.
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

printf "Rename default boot disk name\n"
  if [[ -d "/Volumes/Macintosh HD" ]]; then
     printf "Renaming boot disks:"
     /usr/sbin/diskutil rename "Macintosh HD" "macOS"
  fi

printf "System - Download raw list hosts to block known malware, advertising or otherwise unwanted domains.\n"
sleep 3
#
sudo cp -p /etc/hosts /etc/hosts.${datestamp}
echo "Copying down raw list hosts file (Must have connection to internet)...\n"
curl "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" | sudo tee /etc/hosts
sleep 3

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

printf "Mouse - Smooth Scrolling - Useful if you’re on an older Mac that messes up the animation.\n"
# Disable
#defaults write -g NSScrollAnimationEnabled -bool false
# Enable (Default)
defaults write -g NSScrollAnimationEnabled -bool true

printf "Scrollbar Visibility - Possible values: WhenScrolling, Automatic and Always.\n"
defaults write -g AppleShowScrollBars -string "Always"

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

printf "Dock - Add a Stack with Recent Applications\n"
defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }' && \
killall Dock

printf "Dock - Remove all default app icons\n"
#  defaults write com.apple.dock persistent-apps -array

printf "Dock - Automatically hide and show\n"
#  defaults write com.apple.dock autohide -bool true

printf "Dock - Remove the auto-hiding delay\n"
#  defaults write com.apple.Dock autohide-delay -float 0

printf "Dock - Don’t show Dashboard as a Space\n"
#  defaults write com.apple.dock "dashboard-in-overlay" -bool true

printf "iCloud - Save to disk by default (not to iCloud)\n"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

printf "Finder - Show the $HOME/Library folder\n"
chflags nohidden $HOME/Library

printf "Finder - Show the /Volumes folder\n"
chflags nohidden /Volumes

printf "Finder - Show hidden files\n"
  defaults write com.apple.finder AppleShowAllFiles -bool true

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
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

printf "Time Machine - Prevent prompting to use new hard drives as backup volume\n"
defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

printf "Time Machine - Change Backup Interval. The integer value is the time in seconds.\n"
# Needs to be investigated:
sudo defaults write /System/Library/Launch Daemons/com.apple.backupd-auto StartInterval -int 10800

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

printf "System - Setup Hot Corners"
# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Start screen saver
defaults write com.apple.dock wvous-tl-corner -int 5
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner →
#defaults write com.apple.dock wvous-tr-corner -int 0
#defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Mission Control
defaults write com.apple.dock wvous-bl-corner -int 2
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom Right screen corner → Show Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

printf "Google - Uninstall Google Update\n"
~/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/ksinstall --nuke


elif [ "$function" == "disable:callhome" ]; then
bash applecallhome.sh fixmacos

elif [ "$function" == "enable:callhome" ]; then
bash applecallhome.sh restore

elif [ "$function" == "refresh:hosts" ]; then
echo "Making copy of current /etc/hosts to /etc/hosts.${datestamp}"
sudo cp -p /etc/hosts /etc/hosts.${datestamp}
echo "Copying down updated raw list hosts file (Must have connection to internet)...\n"
curl "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" | sudo tee /etc/hosts
sleep 1
echo "Copying in local template entries"
if [ -f ~/Scripts/hosts.local.template ]; then
  cat ~/Scripts/hosts.local.template | sudo tee -a /etc/hosts
fi
echo "Refreshing local DNS"
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder 
echo "DNS cache cleared"

elif [ "$function" == "install:ctags" ]; then
  if [ ! -d ~/Downloads/ctags-5.8 ]; then
    cd ~/Downloads
    curl -O http://peterszaro.com/ctags-5.8.tar.gz
    tar xzvf ctags-5.8.tar.gz
    cd ~/Downloads/ctags-5.8
    ./configure
    make
    sudo make install
  fi

elif [ "$function" == "install:brewpip" ]; then

# Installs Homebrew and PIP software

#
# Homebrew
#

# If older ctags version exists, delete file
[ -f /usr/local/bin/ctags ] && rm '/usr/local/bin/ctags'

if ! command -v brew > /dev/null; then
  ruby -e "$(curl --location --fail --silent --show-error https://raw.githubusercontent.com/Homebrew/install/master/install)"
  export PATH="/usr/local/bin:$PATH"
  printf "export PATH=\"/usr/local/bin:$PATH\"\n" >> $HOME/.bash_profile
fi

# According to Homebrew's Anonymous Aggregate User Behaviour Analytics, Homebrew gathers anonymous aggregate user behaviour analytics and reporting these to Google Analytics. To opt out of Homebrew's analytics:
brew analytics off

# mas
brew install mas

# ctags
brew install ctags

# Readline
brew install readline

# OpenSSL
brew install openssl
brew link openssl --force

# Python
brew install python

# Bash
brew install bash

# Bash Completion
brew install bash-completion

# ShellCheck
brew install shellcheck

# Tree
brew install tree

# Git
brew install git

# GitHub
brew install hub

# GitHub Issues
brew install ghi

# Terminal Notifier
brew install terminal-notifier

# Watchman
brew install watchman

# Silver Searcher
brew install the_silver_searcher

# jq (https://stedolan.github.io/jq/)
brew install jq

# libdvdcss (since it was removed in El Capitan - https://www.reddit.com/r/osx/comments/3n6gz4/el_capitan_apparently_broke_handbrake_ripping/)
brew install libdvdcss

# ccat
brew install ccat

# gcc
brew install gcc

# speedtest-cli
brew install speedtest-cli

# mackup
brew install mackup

# StormSSH
brew install stormssh

# wget
brew install wget

# dockutil
brew install dockutil

# known_hosts
brew install known_hosts

# dsh
brew install dsh

# Caffiene
brew cask install caffeine

# Brew Cask
brew tap caskroom/cask

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#
# PIP
#

# AWS CLI https://aws.amazon.com/cli/
${PIPLOC}/pip install awscli

# glances (https://nicolargo.github.io/glances/)
${PIPLOC}/pip install glances

# Ansible
${PIPLOC}/pip install ansible

elif [ "$function" == "remove:brewpip" ]; then
  echo "Discovering brew packages installed and will remove..."
  for p in `brew list`; do brew remove $p; done
  echo "Discovering pip packages installed and will remove..."
  for p in `${PIPLOC}/pip list`; do ${PIPLOC}/pip uninstall $p; done

elif [ "$function" == "update:brewpip" ]; then
  echo "Updating Homebrew and its installed packages..."
  printf "${GREEN}brew update; brew upgrade; brew cleanup;\n${NC}"
  brew update; brew upgrade; brew cleanup;
  echo
  sleep 3
  echo
  echo "Updating installed pip packages..."
  printf "${GREEN}pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U\n${NC}"
  ${PIPLOC}/pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 ${PIPLOC}/pip install -U

elif [ "$function" == "install:software" ]; then

  xcode_install

  echo "Installing Applications via cask..."
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  brew cask install dropbox
  brew cask install gitup
  brew cask install textexpander
  brew cask install google-chrome
  brew cask install transmit
  brew cask install divvy
  brew cask install iterm2
  brew cask install growlnotify
  brew cask install cleanmymac
  brew cask install geektool
  brew cask install atom
  brew cask install timemachineeditor
  brew cask install nvalt
  brew cask install bartender
  brew cask install etcher

# Install OS X software updates, update installed Ruby gems, Homebrew, pip and their installed packages
elif [ "$function" == "update" ]; then
   echo "Updating OS X..."
   printf "${GREEN}sudo softwareupdate -i -a;\n${NC}"
   sudo softwareupdate -i -a;
   echo "Your system has been successfully updated"

#--------------------------------------------------------------------
# General Utilities
#--------------------------------------------------------------------
elif [ "$function" == "lock" ]; then
    printf "${GREEN}/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend\n\n${NC}"
    /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend

elif [ "$function" == "restart" ]; then
  printf "${GREEN}osascript -e 'tell app 'loginwindow' to «event aevtrrst»''\n\n${NC}"
  osascript -e 'tell app "loginwindow" to «event aevtrrst»'

elif [ "$function" == "sleep" ]; then
  printf "${GREEN}pmset sleepnow\n\n${NC}"
  pmset sleepnow

elif [ "$function" == "shutdown" ]; then
  printf "${GREEN}osascript -e 'tell app 'loginwindow' to «event aevtrsdn»'\n\n${NC}"
  osascript -e 'tell app "loginwindow" to «event aevtrsdn»'

elif [ "$function" == "time" ]; then
  printf "${GREEN}while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'\n\n${NC}"
  while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &

# Remove files older than X days in current folder
elif [ "$function" == "files:remove-older" ]; then
  printf "${GREEN}find . -ctime +${GRAY}${firstParameter}${GREEN} -print0 | xargs -0 -n1\n\n${NC}"
  echo "Removing files older than "$firstParameter" days..."
  find . -ctime +$firstParameter -print0 | xargs -0 -n1

# Calculate folder size
elif [ "$function" == "folder:size" ]; then
  printf "${GREEN}du -sh .\n\n${NC}"
  echo "Calculating folder size...\n"
  echo "Folder size:"
  du -sh .

# List folders in current directory
elif [ "$function" == "folders:list" ]; then
  du -sk * | sort -g | awk '{ numBytes = $1 * 1024; numUnits = split("B K M G T P", unit); num = numBytes; iUnit = 0; while(num >= 1024 && iUnit + 1 < numUnits) { num = num / 1024; iUnit++; } $1 = sprintf( ((num == 0) ? "%6d%s " : "%6.1f%s "), num, unit[iUnit + 1]); print $0; }'

# Remove empty subdirectories
elif [ "$function" == "folders:remove-empty" ]; then
  printf "${GREEN}find . -type d -empty -delete\n\n${NC}"
  find . -type d -empty -delete

# Close all opened apps
elif [ "$function" = "apps:close-all" ]; then
  printf "${GREEN}ignore='grep\|iTerm\|Finder\|Dropbox\|Bartender'\n${NC}"
  printf "${GREEN}ps aux | grep /Applications | grep -v $ignore | sed "s/\ *\ /\ /g" | cut -d ' ' -f 2 | xargs -I X kill -9 X\n\n${NC}"
  # To customize ignored apps, just put the keywords in $ignore
  # To test which apps you are going to kill, run:
  # ps aux | grep /Applications | grep -v $ignore | sed "s/\ *\ /\ /g" | cut -d ' ' -f 11 | xargs -I X echo X
  ignore="grep\|iTerm\|Finder\|Dropbox\|Bartender"
  ps aux | grep /Applications | grep -v $ignore | sed "s/\ *\ /\ /g" | cut -d ' ' -f 2 | xargs -I X kill -9 X

# Get list of installed apps from the App Store
elif [ "$function" == "apps:app-store" ]; then
  printf "${GREEN}find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'\n\n${NC}"
  echo "Getting list of installed apps from the App Store...\n"
  find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'

# Start screensaver
elif [ "$function" == "screensaver" ]; then
  printf "${GREEN}open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app\n\n${NC}"
  open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app

# Display all locally defined accounts  
elif [ "$function" == "display:users" ]; then
  USERS=$(ls -1 /Users)

  for u in $USERS
  do
  if [[ $u = .* ]]; then
    echo > /dev/null
  elif [[ "$u" = Deleted* || "$u" = Users* ]]; then
    echo > /dev/null
  elif [ "$u" = "Shared" ]; then
    echo > /dev/null
  else
    echo $u
  fi
  done

# Display all mounted volumes and disk
elif [ "$function" == "display-all" ]; then
  diskutil list -plist      |\
  fgrep -A1 '<key>MountPoint</key>'   |\
  fgrep -v '<string>/</string>'     |\
  egrep "</string>$"      |\
  sed 's#</string>##g ; s#.*<string>##g'

# Eject all mounted volumes and disk
elif [ "$function" == "eject-all" ]; then
  printf "${GREEN}osascript -e 'tell application 'Finder' to eject (every disk whose executable is true)'\n\n${NC}"
  osascript -e 'tell application "Finder" to eject (every disk whose executable is true)'

# Get battery information
elif [ "$function" == "battery:status" ]; then
  printf "${GREEN}system_profiler SPPowerDataType | awk '/Full/ || /Remaining/ || /Cycle/ { printf }' | sed -e 's/[^:]*/Battery/' -e 's/ *R.*):./\//' -e 's/ *Cycle/ (mAh)     Cycle/'\n\n${NC}"
  system_profiler SPPowerDataType | awk '/Full/ || /Remaining/ || /Cycle/ { printf }' | sed -e 's/[^:]*/Battery/' -e 's/ *R.*):./\//' -e 's/ *Cycle/ (mAh)     Cycle/'

# Get OS X version information
elif [ "$function" == "info" ]; then
  printf "${GREEN}/usr/bin/sw_vers -productVersion\n\n${NC}"
  /usr/bin/sw_vers -productVersion

# Find text in current directory
elif [ "$function" == "find:text" ]; then

  if [ ! -z "$allParameters" -a "$allParameters" != " " ]; then
        echo "Please enter the extension to search (i.e.: csv): "

      read extension

    if [ ! -z "$extension" -a "$extension" != " " ]; then

            printf "${GREEN}find . -iname '*.${GRAY}${extension}${GREEN}' | xargs grep -in --color '${GRAY}${allParameters}${GREEN}'${NC}"
            echo "\nRecursively find '"$allParameters"' inside directory...\n"
            find . -iname "*.$extension" | xargs grep -in --color "$allParameters"

    else
            echo "Please introduce the extension of the files to search. E.g: csv\n"
    fi
  else
    echo "Please introduce text to search. E.g:\n"
    echo "go find:text Sample Search Text"
  fi

# Find biggest files in current directory
elif [ "$function" == "find:biggest-files" ]; then
    printf "${GREEN}find . -type f -print0 | xargs -0 du | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {}${NC}"
    find . -type f -print0 | xargs -0 du | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {}


# Find biggest directories in current directory
elif [ "$function" == "find:biggest-directories" ]; then
    printf "${GREEN}find . -type d -print0 | xargs -0 du | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {}${NC}"
    find . -type d -print0 | xargs -0 du | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {}

# Extract Zip file
elif [ "$function" == "zip:extract" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
    printf "${GREEN}unzip ${GRAY}${firstParameter}\n\n${NC}"
    unzip $firstParameter
  else
    echo "Please specify the Zip file to extract.\n"
    echo "E.g.: zip:extract sample_file.zip"
  fi

# Compress Gzip file
elif [ "$function" == "gzip:compress" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
    printf "${GREEN}gzip ${GRAY}${firstParameter}\n\n${NC}"
    gzip $firstParameter
  else
    echo "Please specify the file to compress.\n"
    echo "E.g.: gzip:compress sample_file"
  fi

# Extract Gzip file
elif [ "$function" == "gzip:extract" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
    printf "${GREEN}gzip -d ${GRAY}${firstParameter}\n\n${NC}"
    gzip -d $firstParameter
  else
    echo "Please specify the Gzip file to extract.\n"
    echo "E.g.: gzip:extract sample_file.gz"
  fi

# Extract tar file
elif [ "$function" == "tar:extract" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
    printf "${GREEN}tar -xvzf ${GRAY}${firstParameter}\n\n${NC}"
    tar -xvzf $firstParameter
  else
    echo "Please specify the tar file to extract.\n"
    echo "E.g.: tar:extract sample_file.tgz"
  fi

# Compress file/folder using TAR with progress indicator
elif [ "$function" == "tar:compress" ]; then
  echo "Please enter the filename to save the .tgz file: "

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
    read filename

    if [ ! -z "$filename" -a "$filename" != " " ]; then
      printf "${GREEN}tar -czf${GRAY} : ${firstParameter}${GREEN}  | (pv -p --timer --rate --bytes > '${GRAY}${filename}${GREEN}'.tgz)\n\n${NC}"
      tar -czf - $firstParameter | (pv -p --timer --rate --bytes > "$filename".tgz)
    else
      "Please specify the file name"
    fi
  else
    echo "Please specify the folder or directory to compress."
    echo "E.g.: tar:compress foldername"
  fi

# Search and replace string on file
elif [ "$function" == "search:replace" ]; then
  echo "Please enter the string to search on the file:"

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
    read searchString

    if [ ! -z "$searchString" -a "$searchString" != " " ]; then

            echo "Please enter the string that will replace the search string:"
            read replaceString

            if [ ! -z "$replaceString" -a "$replaceString" != " " ]; then

                printf "${GREEN}LC_CTYPE=C sed -i 's#${GRAY}${searchString}${GREEN}#${GRAY}${replaceString}${GREEN}#g' ${GRAY}${firstParameter}\n\n${NC}"
            LC_CTYPE=C sed -i 's#'"${searchString}"'#'"${replaceString}"'#g' $firstParameter

            else
          "Please specify the string to replace"
        fi

    else
      "Please specify the string to search"
    fi
  else
    echo "Please specify the file to perform the search and replace operation"
    echo "E.g.: search:replace /path/to/file.csv"
  fi

# Determine SSID & Password
elif [ "$function" == "getwifipw" ]; then
  echo "Obtaining WiFi Password...\n"
   SSID=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'`
   SSIDPW=`security find-generic-password -wa $SSID`
   echo "Current SSID: $SSID - $SSIDPW"

# Create Space In Dock
elif [ "$function" == "spacedock" ]; then
  echo "Creating space in dock...\n"
   defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}' && \
   killall Dock

# Create Small Space In Dock
elif [ "$function" == "smallspacedock" ]; then
  echo "Creating space in dock...\n"
   defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}' && \
   killall Dock

# Turn Indexing Off
elif [ "$function" == "turnindexingoff" ]; then
  echo "Turning Spotlight Indexing Off...\n"
   sudo mdutil -a -i off

# Turn Indexing On
elif [ "$function" == "turnindexingon" ]; then
  echo "Turning Spotlight Indexing On...\n"
   sudo mdutil -a -i on

elif [ "$function" == "airplane-mode:status" ]; then
  echo "Checking WiFi and Bluetooth status...\n"
  echo
  echo " WiFi Status: "
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I   
  echo
  echo " Bluetooth Status: "
  defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState | awk '{ if($1 != 0) {print "Bluetooth: ON"} else { print "Bluetooth: OFF" }  }'
elif [ "$function" == "airplane-mode:on" ]; then
  echo "Enabling airplane mode...\n"
   networksetup -setairportpower airport off
   networksetup -setairportpower en0 off
   networksetup -setairportpower en1 off
   sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0 && \
        sudo killall -HUP blued
elif [ "$function" == "airplane-mode:off" ]; then
  echo "Disabling airplane mode...\n"
   networksetup -setairportpower airport on
   networksetup -setairportpower en0 on
   networksetup -setairportpower en1 on
   sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 1 && \
        sudo killall -HUP blued


#--------------------------------------------------------------------
# Time Machine
#--------------------------------------------------------------------

# Enable Local Time Machine Backups
elif [ "$function" == "tmenable" ]; then
  echo "Enabling Local Time Machine Backups...\n"
  sudo tmutil enablelocal

# Disable Local Time Machine Backups
elif [ "$function" == "tmdisable" ]; then
  echo "Disable Local Time Machine Backups...\n"
  sudo tmutil disablelocal

# Disable Local Time Machine Backups While on Battery
elif [ "$function" == "tmdisablebattery" ]; then
  echo "Disable Local Time Machine Backups While on Battery...\n"
  sudo defaults write /Library/Preferences/com.apple.TimeMachine RequiresACPower -bool true

# Display Latest Time Machine Backup
elif [ "$function" == "tmlatest" ]; then
  echo "Displaying Latest Time Machine Backup...\n"
   tmutil latestbackup | awk -F '/' '{print $6}'

# Display Full List Of Time Machine Backups
elif [ "$function" == "tmlist" ]; then
  echo "Displaying Full List of Time Machine Backups...\n"
   tmutil listbackups

#--------------------------------------------------------------------
# Search Utilities
#--------------------------------------------------------------------
# Find files modified in the last N minutes
elif [ "$function" == "find:recent" ]; then
  echo "Searching for files modified in the last "$firstParameter" minutes..."
  printf "${GREEN}sudo find / -mmin ${GRAY}${firstParameter}${GREEN} -type f\n\n${NC}"
  sudo find / -mmin $firstParameter -type f

# Find duplicated files
elif [ "$function" == "find:duplicated" ]; then
find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate

#--------------------------------------------------------------------
# Network Utilities
#--------------------------------------------------------------------
# Internet connection speed test
elif [ "$function" == "speedtest" ]; then
  echo
  speedtest-cli
  echo

# List of used ports
elif [ "$function" == "ports" ]; then
  echo "Getting list of used ports..."
  printf "${GREEN}sudo lsof -iTCP -sTCP:LISTEN -P\n\n${NC}"
  sudo lsof -iTCP -sTCP:LISTEN -P

# Get local IP address
elif [ "$function" == "ip:local" ]; then
  INTERFACE=`route -n get default | awk /interface:/'{print $2}'`
  echo
  echo "Internal IP (${INTERFACE}): `ipconfig getifaddr ${INTERFACE}`"
  echo

# Get public IP address
elif [ "$function" == "ip:public" ]; then
  INTERFACE=`route -n get default | awk /interface:/'{print $2}'`
  echo
  echo "Extenal IP (${INTERFACE}): `dig +short myip.opendns.com @resolver1.opendns.com`"
  echo

# Get MAC address
elif [ "$function" == "ip:mac" ]; then
  INTERFACE=`route -n get default | awk /interface:/'{print $2}'`
  echo
  echo "MAC Address (${INTERFACE}): `ifconfig ${INTERFACE} | awk /ether\ /'{print $2}'` "
  echo

#--------------------------------------------------------------------
# SSH Utilities
#--------------------------------------------------------------------

# Download file through SSH on current folder
elif [ "$function" == "ssh:download-file" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then

    echo "Please enter the server IP address or domain: "

    read ipaddress
    if [ ! -z "$ipaddress" -a "$ipaddress" != " " ]; then

      echo "Please enter username: "

      read username

      if [ ! -z "$username" -a "$username" != " " ]; then

        printf "${GREEN}scp ${GRAY}${username}@${ipaddress}:${firstparameter}${GREEN} .\n\n${NC}"
        scp $username@$ipaddress:$firstParameter .

      else
        "Please specify the username for the remote server"
      fi

    else
      "Please specify the server IP address or domain"
    fi

  else
    echo "Please specify the path to the file on the remote server to download"
    echo "E.g.: /home/sample/file.jpg"
  fi

# Download entire folder through SSH on current directory
elif [ "$function" == "ssh:download-folder" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then

    echo "Please enter the server IP address or domain: "

    read ipaddress
    if [ ! -z "$ipaddress" -a "$ipaddress" != " " ]; then

      echo "Please enter username: "

      read username

      if [ ! -z "$username" -a "$username" != " " ]; then

        printf "${GREEN}scp -r ${GRAY}${username}@${ipaddress}:${firstparameter}${GREEN} .\n\n${NC}"
        scp -r $username@$ipaddress:$firstParameter .

      else
        "Please specify the username for the remote server"
      fi

    else
      "Please specify the server IP address or domain"
    fi

  else
    echo "Please specify the path to the folder on the remote server to download"
    echo "E.g.: /home/sample/folder/"
  fi


# Download remote database through SSH on current directory
elif [ "$function" == "ssh:download-database" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then

    echo "Please enter the server IP address or domain: "

    read ipaddress
    if [ ! -z "$ipaddress" -a "$ipaddress" != " " ]; then

      echo "Please enter username: "

      read username

      if [ ! -z "$username" -a "$username" != " " ]; then

        echo ""
        printf "${GREEN}scp -r ${GRAY}${username}@${ipaddress}:${firstparameter}${GREEN} .\n\n${NC}"
        scp -r $username@$ipaddress:$firstParameter .

      else
        "Please specify the username for the remote server"
      fi

    else
      "Please specify the server IP address or domain"
    fi

  else
    echo "Please specify the database name on the remote server to download"
    echo "E.g.: go ssh:download-database database-name"
  fi


elif [ "$function" == "ssh:sync:local" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then

    echo "Please enter the server IP address or domain: "

    read ipaddress
    if [ ! -z "$ipaddress" -a "$ipaddress" != " " ]; then

      echo "Please enter username: "

      read username

      if [ ! -z "$username" -a "$username" != " " ]; then

                echo "Please enter local folder to sync with the remote folder: "

                read localfolder

                if [ ! -z "$localfolder" -a "$localfolder" != " " ]; then
                    printf "${GREEN}rsync -a --progress ${GRAY}${username}@${ipaddress}:${firstparameter} ${localfolder}${GREEN}\n\n${NC}"
                    rsync -a --progress ${username}@${ipaddress}:${firstparameter} ${localfolder}

                else
                    "Please specify the local folder to sync with the remote folder"
                fi
      else
        "Please specify the username for the remote server"
      fi

    else
      "Please specify the server IP address or domain"
    fi

  else
    echo "Please specify the remote folder path to sync"
    echo "E.g.: go ssh:sync:remote /var/www/html/media/"
  fi



elif [ "$function" == "ssh:sync:remote" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then

    echo "Please enter the server IP address or domain: "

    read ipaddress
    if [ ! -z "$ipaddress" -a "$ipaddress" != " " ]; then

      echo "Please enter username: "

      read username

      if [ ! -z "$username" -a "$username" != " " ]; then

                echo "Please enter local folder to sync from the remove folder: "

                read localfolder

                if [ ! -z "$localfolder" -a "$localfolder" != " " ]; then
                    printf "${GREEN}rsync -a ${localfolder} ${username}@${ipaddress}:${firstparameter}\n\n${NC}"
                    rsync -a --progress ${localfolder} ${username}@${ipaddress}:${firstparameter}

                else
                    "Please specify the local folder to sync from the remote folder"
                fi
      else
        "Please specify the username for the remote server"
      fi

    else
      "Please specify the server IP address or domain"
    fi

  else
    echo "Please specify the remote folder path to sync"
    echo "E.g.: go ssh:sync:remote /var/www/html/media/"
  fi



# Upload file to remote server through SSH
elif [ "$function" == "ssh:upload" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then

    echo "Please enter the server IP address or domain: "

    read ipaddress

    if [ ! -z "$ipaddress" -a "$ipaddress" != " " ]; then

      echo "Please enter username: "

      read username

      if [ ! -z "$username" -a "$username" != " " ]; then

          echo "Please enter path on the remote server to upload the file: "

          read remotePath

          if [ ! -z "$remotePath" -a "$remotePath" != " " ]; then

            printf "${GREEN}scp ${GRAY}${firstParameter} ${username}@${ipaddress}:${remotePath}${GREEN}\n\n${NC}"
            scp $firstParameter $username@$ipaddress:$remotePath

          else
            "Please specify the path on the remote server to upload the file"
          fi

      else
        "Please specify the username for the remote server"
      fi

    else
      "Please specify the server IP address or domain"
    fi

  else
    echo "Please specify the path to the file to upload to the remote server"
    echo "E.g.: /user/example/documents/file.pdf"
  fi

# SSH key Utilities
elif [ "$function" == "ssh:public-key" ]; then
  printf "${GREEN}pbcopy < ~/.ssh/id_rsa.pub \n\n${NC}"
  pbcopy < ~/.ssh/id_rsa.pub


# List saved SSH credentials
elif [ "$function" == "ssh:list" ]; then
  printf "${GREEN}storm list \n\n${NC}"
  storm list


#--------------------------------------------------------------------
# Web Development Utilities
#--------------------------------------------------------------------

elif [ "$function" == "dev:monitor" ]; then

  if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
        printf "${GREEN}tail -f ${GRAY}${firstParameter}\n\n${NC}"
        tail -f $firstParameter
  else
    echo "Please specify the file to monitor"
    echo "E.g.: monitor /path/to/file.sql"
  fi

# Compile SCSS styles in current folder using compass
elif [ "$function" == "dev:compass:compile" ]; then
    printf "${GREEN}compass compile . \n\n${NC}"
  compass compile .

# Download all images from website to current directory
elif [ "$function" == "web:download-images" ]; then

    if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
        printf "${GREEN}wget -r -l 1 -A jpeg,jpg,bmp,gif,png ${GRAY}${firstParameter}'\n\n${NC}"
        wget -r -l 1 -A jpeg,jpg,bmp,gif,png ${firstParameter}
        # Remove empty subdirectories
        find . -type d -empty -delete

    else
        echo "Please specify the full URL of the website to download the images"
        echo "E.g.: web:download-images http://example.com/sample-page"
    fi

# Get list of installed Homebrew packages
elif [ "$function" == "dev:optimize-images" ]; then
    echo "Optimizing all images in current directory and subdirectories...\n"
    printf "${GREEN}imageoptim --directory .\n\n${NC}"
    imageoptim --directory .

# Convert CSS file to SCSS
elif [ "$function" == "dev:css:convert-to-scss" ]; then

    if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then

        if [[ $firstParameter == *".css"* ]];  then
            printf "${GREEN}cp ${GRAY}${firstParameter} ${firstParameter/css/scss}${GREEN} email-non-inline.scss && sass-convert --from css --to scss --in-place ${GRAY}${firstParameter/css/scss}'\n\n${NC}"
            cp ${firstParameter} ${firstParameter/css/scss} && sass-convert --from css --to scss --in-place ${firstParameter/css/scss}
        else
            echo "The specified file is not a CSS file"
            echo "Please specify the CSS file to convert"
            echo "E.g.: dev:css:convert-to-scss styles.css"
        fi

    else
        echo "Please specify the CSS file to convert"
        echo "E.g.: dev:css:convert-to-scss styles.css"
    fi

#--------------------------------------------------------------------
# Performance and maintenance Utilities
#--------------------------------------------------------------------

# See memory usage sorted by memory consumption
elif [ "$function" == "system" ]; then
  printf "${GREEN}glances \n\n${NC}"
  glances

# See memory usage sorted by memory consumption
elif [ "$function" == "memory" ]; then
  printf "${GREEN}top -o MEM \n\n${NC}"
  top -o MEM

# Empty trash
elif [ "$function" == "trash:empty" ]; then
  printf "${GREEN}sudo rm -rf ~/.Trash/* \n\n${NC}"
  sudo rm -rf ~/.Trash/*

# Calculate trash size
elif [ "$function" == "trash:size" ]; then
  printf "${GREEN}du -sh ~/.Trash/ \n\n${NC}"
  echo "Trash size: \n"
  du -sh ~/.Trash/

#--------------------------------------------------------------------
# iTerm Utilities
#--------------------------------------------------------------------

# Set title to current iTerm tab
elif [ "$function" == "iterm:tab-title" ]; then
    printf "${GREEN}echo -ne '\033]0;'${GRAY}${firstparameter}${GREEN}'\007'\n\n${NC}"
  echo -ne '\033]0;'$allParameters'\007'
  echo "Tab title updated"

#--------------------------------------------------------------------
# GIT Utilities
#--------------------------------------------------------------------

# Install my git repos (if not installed)
elif [ "$function" == "getmygit" ]; then
  echo "Checking git repos..."
  if [[ -d ~/dotfiles ]]; then
   echo
   echo "Looks like my dotfiles GIT repo is installed...."
   echo
  else
   [ -f $HOME/.bash_profile ] && rm -f $HOME/.bash_profile
     git clone "git://github.com/pszaro/dotfiles.git"
     mv dotfiles ~/
   if [ $? = 0 ]; then
    echo "Git Repo dotfiles moved to $HOME/dotfiles"
   fi
   [ -f $HOME/.bashrc ] && source $HOME/.bashrc
     echo
     echo
     echo "Reminder: Execute ./run.sh under ~/dotfiles"
     echo
     echo
  fi
  [[ ! -d ~/git-repos ]] && mkdir ~/git-repos
  if [[ -d ~/git-repos/mac-setup-playbook ]]; then
    echo
    echo "Looks like my mac-setup-playbook GIT repo is installed...."
    echo
  else
    git clone "git://github.com/pszaro/mac-setup-playbook.git"
    mv mac-setup-playbook ~/git-repos/
    if [ $? = 0 ]; then
      echo "Git Repo mac-setup-playbook moved to ~/git-repos/mac-setup-playbook"
    fi
  fi

# Display local Git configuration
elif [ "$function" == "git:config" ]; then
    printf "${GREEN}git config --list\n\n${NC}"
  git config --list

# Open current Git repository on Github
elif [ "$function" == "git:open" ]; then
  giturl=$(git config --get remote.origin.url)
      if [ "$giturl" == "" ]
        then
         echo "Not a git repository or no remote.origin.url set"
         exit 1;
      fi
      giturl=${giturl/git\@github\.com\:/https://github.com/}
      giturl=${giturl/\.git/\/}
      branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
      branch="(unnamed branch)"     # detached HEAD
      branch=${branch##refs/heads/}
      giturl=$giturl
      open $giturl

# Create GIT branch based on current branch
elif [ "$function" == "git:create:branch" ]; then

    if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
        printf "${GREEN}git checkout -b ${GRAY}$firstParameter\n\n${NC}"
      git checkout -b $firstParameter

    else
        echo "Please specify the name for the new branch"
        echo "E.g.: git:create:branch sample-branch"
    fi

# Get last update date for all branches in current project
elif [ "$function" == "git:branches" ]; then
  git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'

# Undo latest commit
elif [ "$function" == "git:undo-commit" ]; then
    printf "${GREEN}git reset --soft HEAD~\n\n${NC}"
  git reset --soft HEAD~

# See latest commits IDs and titles for current branch
elif [ "$function" == "git:log" ]; then
  git log --pretty=oneline

# See all branches
elif [ "$function" == "git:branch" ]; then
  git branch -a

# Rename GIT branch
elif [ "$function" == "git:branch:rename" ]; then

   if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
        printf "${GREEN}git branch -m ${GRAY}$firstParameter\n\n${NC}"
      git branch -m $firstParameter

    else
        echo "Please specify the name of the branch to rename"
        echo "E.g.: git:branch:rename sample-branch"
    fi

# Remove local GIT branch
elif [ "$function" == "git:branch:remove-local" ]; then

   if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
        printf "${GREEN}git branch -d ${GRAY}$firstParameter\n\n${NC}"
      git branch -d $firstParameter

    else
        echo "Please specify the name of the branch to remove"
        echo "E.g.: git:branch:remove-local sample-branch"
    fi

# Remove local and remote GIT branch
elif [ "$function" == "git:branch:remove-remote" ]; then

   if [ ! -z "$firstParameter" -a "$firstParameter" != " " ]; then
        printf "${GREEN}git branch -d ${GRAY}$firstParameter\n\n${NC}"
      git branch -d $firstParameter
        printf "${GREEN}git push origin --delete ${GRAY}$firstParameter\n\n${NC}"
      git push origin --delete $firstParameter

    else
        echo "Please specify the name of the branch to remove"
        echo "E.g.: git:branch:remove-remote sample-branch"
    fi

# Check GIT settings
elif [ "$function" == "git:settings" ]; then
  git config --list

# Add removed files to staged files
elif [ "$function" == "git:add-removed" ]; then
  git add -u

# Remove GIT from current project
elif [ "$function" == "git:remove" ]; then
  find . -name '.git' -exec rm -rf {} \;

# Open current GIT repository URL
elif [ "$function" == "git:open" ]; then
  open `git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@'`| head -n1

# Get size of current GIT repository
elif [ "$function" == "git:size" ]; then
  git bundle create tmp.bundle --all
  printf "\n\nCurrent GIT repository size: \n"
  du -sh tmp.bundle
  rm tmp.bundle

#--------------------------------------------------------------------

else
  printf "\nCommand not found: "
  printf "$function"
  printf "\nParameters: "
  printf "$allParameters"
fi
