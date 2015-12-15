#!/bin/bash
#
# Description: Installs Homebrew and PIP software.
#

# EXECUTION
# Homebrew
if ! command -v brew > /dev/null; then
  ruby -e "$(curl --location --fail --silent --show-error https://raw.githubusercontent.com/Homebrew/install/master/install)"
  export PATH="/usr/local/bin:$PATH"
  printf "export PATH=\"/usr/local/bin:$PATH\"\n" >> $HOME/.bash_profile
fi

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

############################################################################################
############################################################################################

# AWS CLI https://aws.amazon.com/cli/
pip install awscli
