#!/bin/bash

# DESCRIPTION
# Installs Homebrew software.

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

# Python3
brew install python3

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
