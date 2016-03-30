#!/bin/bash
#
# Description: Installs OSX applications.
#

# Installing the Xcode command line tools on 10.9.x or higher

osx_vers=$(sw_vers -productVersion | awk -F "." '{print $2}')
cmd_line_tools_temp_file="${tmpDir}/.com.apple.dt.CommandLineTools.installondemand.in-progress"

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

# EXECUTION
# Dropbox
install_dmg_app "$DROPBOX_APP_URL" "Dropbox Installer" "$DROPBOX_APP_NAME"

# GitUp
install_zip_app "$GIT_UP_APP_URL" "$GIT_UP_APP_NAME"

# TextExpander
install_zip_app "$TEXTEXPANDER_APP_URL" "$TEXTEXPANDER_APP_NAME"

# Google Chrome
install_dmg_app "$CHROME_APP_URL" "Google Chrome" "$CHROME_APP_NAME"

# Transmit
install_zip_app "$TRANSMIT_APP_URL" "$TRANSMIT_APP_NAME"

# Divvy
install_zip_app "$DIVVY_APP_URL" "$DIVVY_APP_NAME"

# iTerm2
install_zip_app "$ITERM_APP_URL" "$ITERM_APP_NAME"

# Flux
install_zip_app "$FLUX_APP_URL" "$FLUX_APP_NAME"

# Handbrake
install_dmg_app "$HANDBRAKE_APP_URL" "$HANDBRAKE_APP_NAME"

# Growl Notify
install_zip_app "$GROWLNOTIFY_APP_URL" "$GROWLNOTIFY_APP_NAME"

# Clean My Mac 3
install_dmg_app "$CLEANMYMAC_APP_URL" "$CLEANMYMAC_APP_NAME"

# GeekTool
install_zip_app "$GEEKTOOL_APP_URL" "$GEEKTOOL_APP_NAME"

# Atom
install_zip_app "$ATOM_APP_URL" "$ATOM_APP_NAME"

# Time Machine Editor
install_zip_app "$TME_APP_URL" "$TME_APP_NAME"

# nvALT
install_zip_app "$NVALT_APP_URL" "$NVALT_APP_NAME"

# Bartender 2
install_zip_app "$BT2_APP_URL" "$BT2_APP_NAME"
