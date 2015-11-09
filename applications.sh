#!/bin/bash

# DESCRIPTION
# Installs OSX applications.

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
