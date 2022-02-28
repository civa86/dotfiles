#!/usr/bin/env bash

#completion_desc::List all profiles of AWS credential file

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

# FUNCTIONS
function usage() {
  echo "DESCRIPTION"
  echo -e "\tList all profiles of AWS credential file"
  echo "SYNOPSIS"
  echo -e "\tdot aws_profiles"
}

function banner() {
  print_cyan " ___          __ _ _        "
  print_cyan "| _ \_ _ ___ / _(_) |___ ___"
  print_cyan "|  _/ '_/ _ \  _| | / -_|_-<"
  print_cyan "|_| |_| \___/_| |_|_\___/__/"
}

if [ "$1" == "help" ]; then usage && exit 0; fi

clear
banner

if [ -f ~/.aws/credentials ]; then
  cat ~/.aws/credentials | egrep -i "\[(.*)\]" | sed "s/\[/- /g" | sed "s/\]//g"
else
  echo -e "\n[ $(print_yellow "WARN") ] No AWS credentials found."
fi

echo ""
