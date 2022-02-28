#!/usr/bin/env bash

#completion_desc::Get package info

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

# FUNCTIONS
function usage() {
  echo "DESCRIPTION"
  echo -e "\tGet package info"
  echo "SYNOPSIS"
  echo -e "\tdot package_info"
}

function banner() {
  print_cyan " ___         _                 "
  print_cyan "| _ \__ _ __| |____ _ __ _ ___ "
  print_cyan "|  _/ _\` / _| / / _\` / _\` / -_)"
  print_cyan "|_| \__,_\__|_\_\__,_\__, \___|"
  print_cyan "                     |___/     "

}

if [ "$1" == "help" ]; then usage && exit 0; fi

PACKAGE_TYPE=$(get_package_type)

clear
banner

if [ -z "$PACKAGE_TYPE" ]; then
  echo -e "[ $(print_red "ERROR") ] invalid package in $PWD"
  exit 1
fi

echo -e "[ $(print_cyan "$(get_package_name $PACKAGE_TYPE)") ][ $(print_magenta "$(get_package_version $PACKAGE_TYPE)") ]\n"
