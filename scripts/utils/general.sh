#!/usr/bin/env bash

function is_software_installed() {
  if ! [ -x "$(command -v $1)" ]; then
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
