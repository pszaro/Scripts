#!/bin/bash
#
# Description: Installs OSX applications.
#

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
