#!/usr/bin/env bash

set -e

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/scripts/utils.sh

# FUNCTIONS
function usage() {
  echo "DESCRIPTION"
  echo -e "\tInstall dotfiles Services"
  echo "SYNOPSIS"
  echo -e "\t./install [-s service1] [-s service2] ..."
  echo "OPTIONS"
  echo -e "\t-s  (string)  service name"
  echo "SERVICES"
  for SERVICE in $(get_available_services); do
    echo -e "\t- $SERVICE"
  done
}

function banner() {
  print_cyan ' ___   ___ _____ ___ ___ _    ___ ___  '
  print_cyan '|   \ / _ \_   _| __|_ _| |  | __/ __| '
  print_cyan '| |) | (_) || | | _| | || |__| _|\__ \ '
  print_cyan '|___/ \___/ |_| |_| |___|____|___|___/ '
}

function print_recap() {
  clear
  banner

  RESULT=

  if [ ! -z "$INSTALL_DONE" ]; then RESULT="${RESULT}${INSTALL_DONE}"; fi
  if [ ! -z "$INSTALL_IN_PROGRESS" ]; then RESULT="${RESULT}${INSTALL_IN_PROGRESS}"; fi

  if [ ! -z "$RESULT" ]; then echo -e "$RESULT"; fi

}

function run_service_install() {
  local SERVICE=$1
  local CMD="$INSTALL_SCRIPTS_PATH/$SERVICE.sh"

  INSTALL_IN_PROGRESS="[ $(print_yellow "$SERVICE") ]"
  print_recap

  $CMD

  if [ "$SERVICE" == "node"]; then nvm use default; fi

  echo -e "\npress key to continue..."
  read -d'' -s -n1
  INSTALL_IN_PROGRESS=
}

function get_available_services() {
  find $INSTALL_SCRIPTS_PATH -name "*.sh" -type f -exec bash -c 'basename $0 | sed "s/\.sh//"' {} \; | sort
}

# CONST
INSTALL_SCRIPTS_PATH=$SCRIPTPATH/scripts/install
SERVICES=
INSTALL_DONE=
INSTALL_IN_PROGRESS=

# PARSE ARGUMENTS
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  --help | -h)
    usage
    exit 0
    ;;
  -s)
    if [ -f "$INSTALL_SCRIPTS_PATH/$2.sh" ]; then
      if [ -z "$SERVICES" ]; then
        SERVICES="$2"
      else
        SERVICES="$SERVICES $2"
      fi
    fi
    shift # past argument
    shift # past value
    ;;
  *)
    print_red "Invalid arguments"
    usage
    exit 1
    ;;
  esac
done

# EXECUTION
trap ctrl_c INT

chmod +x $INSTALL_SCRIPTS_PATH/*.sh

print_recap

if [ -z "$SERVICES" ]; then
  LOOP_INSTALL=1
  AVAILABLE_SERVICES=$(get_available_services)

  while [ $LOOP_INSTALL -eq 1 ]; do
    print_recap

    if [ ! -z "$AVAILABLE_SERVICES" ]; then
      select_box $AVAILABLE_SERVICES
      SELECTED=$SELECT_BOX_CHOICE

      run_service_install "$SELECTED"

      INSTALL_DONE="$INSTALL_DONE[ $(print_green "$SELECTED") ]"
      AVAILABLE_SERVICES=$(echo $AVAILABLE_SERVICES | sed "s/$SELECTED//")
    else
      LOOP_INSTALL=0
    fi
  done
else
  for SERVICE in $SERVICES; do
    print_recap

    run_service_install "$SERVICE"

    INSTALL_DONE="$INSTALL_DONE[ $(print_green "$SERVICE") ]"
  done
fi

# FINISH
print_recap
echo -e "\nAll services installed! $(print_cyan "Bye Bye")\n"
