#!/usr/bin/env bash

# ABSOLUTE SCRIPT PATH
LINK=$(readlink $0)
if [ -z "$LINK" ]; then
  SCRIPTPATH=$0
else
  SCRIPTPATH=$LINK
fi
SCRIPTPATH="$(
  cd -- "$(dirname "$SCRIPTPATH")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/utils.sh

# FUNCTIONS
function help() {
  echo "DESCRIPTION"
  echo -e "\tRun dotfiles commands"
  echo "SYNOPSIS"
  echo -e "\tdot <command> [parameters]"
  echo "COMMANDS"
  for COMMAND in $(get_available_commands); do
    echo -e "\t- $COMMAND"
  done
}

function usage() {
  echo "Usage: dotfiles <command> [parameters]"
  echo -e "To see help text, you can run:\n"
  echo -e "  dotfiles help"
  echo -e "  dotfiles <command> help"
  echo -e "[ $(print_red "ERROR") ] the following arguments are required: command."
}

function banner() {
  print_cyan " ___      _    __ _ _        "
  print_cyan "|   \ ___| |_ / _(_) |___ ___"
  print_cyan "| |) / _ \  _|  _| | / -_|_-<"
  print_cyan "|___/\___/\__|_| |_|_\___/__/"
}

function get_available_commands() {
  local ALL_COMMANDS=$(find $COMMANDS_PATH -name "*.sh" -type f -exec bash -c 'basename $0' {} \; | sort)
  ALL_COMMANDS=$(echo $ALL_COMMANDS | sed "s/\.sh//g" | sed "s/[0-9][0-9][0-9]_//g")
  echo $ALL_COMMANDS
}

# CONST
ARGS=""
COMMANDS_PATH=$SCRIPTPATH/commands

if [ -z $1 ]; then usage && exit 1; fi

CMD=$1
shift

if [ "$CMD" == "help" ]; then help && exit 0; fi
if [ ! -f $COMMANDS_PATH/$CMD.sh ]; then
  help
  echo -e "\n[ $(print_red "ERROR") ] $CMD command not available."
  exit 1
fi

$COMMANDS_PATH/$CMD.sh $@
