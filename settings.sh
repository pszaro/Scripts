#!/bin/bash

# DESCRIPTION
# Defines global settings.

# SETTINGS
# General
set -o nounset # Exit, with error message, when attempting to use an undefined variable.
set -o errexit # Abort script at first error, when a command exits with non-zero status.
set -o pipefail # Returns exit status of the last command in the pipe that returned a non-zero return value.
IFS=$'\n\t' # Defines how Bash splits words and iterates arrays. This defines newlines and tabs as delimiters.
export WORK_PATH=/tmp/downloads # Temporary location for processing of file downloads and installers.


# Applications
export DROPBOX_APP_NAME=Dropbox.app
export DROPBOX_APP_URL="https://www.dropbox.com/download?src=index&plat=mac"

export GIT_UP_APP_NAME=GitUp.app
export GIT_UP_APP_URL="https://s3-us-west-2.amazonaws.com/gitup-builds/stable/GitUp.zip"

export TEXTEXPANDER_APP_NAME=TextExpander.app
export TEXTEXPANDER_APP_URL="http://dl.smilesoftware.com/com.smileonmymac.textexpander/TextExpander.zip"

export CHROME_APP_NAME="Google Chrome.app"
export CHROME_APP_URL="https://dl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg"

export TRANSMIT_APP_NAME=Transmit.app
export TRANSMIT_APP_URL="https://www.panic.com/transmit/d/Transmit%204.4.8.zip"

export DIVVY_APP_NAME=Divvy.app
export DIVVY_APP_URL="http://mizage.com/downloads/Divvy.zip"

export FLUX_APP_NAME=Flux.app
export FLUX_APP_URL="https://justgetflux.com/news/pages/macquickstart#download"

export HANDBRAKE_APP_NAME=Handbrake.app
export HANDBRAKE_APP_URL="http://handbrake.fr/rotation.php?file=HandBrake-0.10.2-MacOSX.6_GUI_x86_64.dmg"
