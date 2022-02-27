#!/usr/bin/env bash

set -e

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
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
  echo "Usage: dot <command> [parameters]"
  echo -e "To see help text, you can run:\n"
  echo -e "  dot help"
  echo -e "  dot <command> help"
  echo -e "[ $(print_red "ERROR") ] the following arguments are required: command."
}

function banner() {
  print_cyan ' ___   ___ _____ ___ ___ _    ___ ___  '
  print_cyan '|   \ / _ \_   _| __|_ _| |  | __/ __| '
  print_cyan '| |) | (_) || | | _| | || |__| _|\__ \ '
  print_cyan '|___/ \___/ |_| |_| |___|____|___|___/ '
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
