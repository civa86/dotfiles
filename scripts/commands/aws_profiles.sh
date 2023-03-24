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

if [ "$1" == "help" ]; then usage && exit 0; fi

clear

banner "AWS"

echo -e "[ $(print_yellow "CREDENTIALS") ]"

if [ -f ~/.aws/credentials ]; then
  cat ~/.aws/credentials | grep -v default | egrep -i "\[(.*)\]" | sed "s/\[/- /g" | sed "s/\]//g"
fi

echo -e "\n[ $(print_yellow "SSO") ]"

if [ -f ~/.aws/config ]; then
  cat ~/.aws/config | grep -v default | egrep -i "\[(.*)\]" | sed "s/profile//g" | sed "s/ //g" | sed "s/\[/- /g" | sed "s/\]//g"
fi

echo ""
