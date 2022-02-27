#!/usr/bin/env bash

function is_software_installed() {
  if ! command -v $1 &>/dev/null; then
    echo 0
  else
    echo 1
  fi
}

function check_software() {
  local IS_SOFTWARE_INSTALLED=$(is_software_installed $1)
  if [ $IS_SOFTWARE_INSTALLED -eq 0 ]; then
    print_error "$1 is not installed" "$2"
  fi
}

function is_file_present() {
  if [ ! -f $1 ]; then
    print_error "$(basename $1) file not found" "$2"
  fi
}

function is_directory_present() {
  if [ ! -d $1 ]; then
    print_error "folder $1 not found" "$2"
  fi
}
