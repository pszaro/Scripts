#!/bin/bash

# DESCRIPTION
# Defines general utility functions.

# Answers the file name.
# Parameters:
# $1 = The file path.
get_file_name() {
  printf "${1##*/}" # Answers file or directory name.
}
export -f get_file_name

# Answers the file extension.
# Parameters:
# $1 = The file name.
get_file_extension() {
  local name=$(get_file_name "$1")
  local extension="${1##*.}" # Excludes dot.

  if [[ "$name" == "$extension" ]]; then
    printf ''
  else
    printf "$extension"
  fi
}
export -f get_file_extension

# Answers the root install path for file name.
# Parameters:
# $1 = The file name.
get_install_root() {
  local file_name="$1"
  local file_extension=$(get_file_extension "$file_name")

  # Dynamically build the install path based on file extension.
  case $file_extension in
    '')
      printf "/usr/local/bin";;
    'app')
      printf "/Applications";;
    'prefPane')
      printf "/Library/PreferencePanes";;
    'qlgenerator')
      printf "/Library/QuickLook";;
    *)
      printf "/tmp/unknown";;
  esac
}
export -f get_install_root

# Answers the full install path (including file name) for file name.
# Parameters:
# $1 = The file name.
get_install_path() {
  local file_name="$1"
  local install_path=$(get_install_root "$file_name")
  printf "$install_path/$file_name"
}
export -f get_install_path

# Cleans work path for temporary processing of installs.
clean_work_path() {
  rm -rf "$WORK_PATH"
}
export -f clean_work_path

# Configures and launches process.
# Parameters:
# $1 = The process config source path.
launch_process() {
  local config_file="$1"
  local config_name="$(get_file_name $config_file)"

  ln -sfv "$config_file" "$HOME/Library/LaunchAgents/$config_name"
  launchctl load "$HOME/Library/LaunchAgents/$config_name"
}
export -f launch_process

# Caffeinate machine.
caffeinate_machine() {
  local pid=$(ps aux | grep caffeinate | grep -v grep | awk '{print $2}')

  if [[ -n "$pid" ]]; then
    printf "Whoa, tweaker, machine is already caffeinated!\n"
  else
    caffeinate -sudit 9999999999 &
    printf "Machine caffeinated and energy saver settings disabled.\n"
  fi
}
export -f caffeinate_machine