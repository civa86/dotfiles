#!/usr/bin/env bash

set -e

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
  # small
  print_cyan "   ___      _____                   __ _ _        "
  print_cyan "  /_\ \    / / __|    _ __ _ _ ___ / _(_) |___ ___"
  print_cyan " / _ \ \/\/ /\__ \   | '_ \ '_/ _ \  _| | / -_|_-<"
  print_cyan "/_/ \_\_/\_/ |___/   | .__/_| \___/_| |_|_\___/__/"
  print_cyan "                     |_|                          "
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
