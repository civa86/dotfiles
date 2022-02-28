#!/usr/bin/env bash

export DOTFILES_HOME=$HOME/Documents/dotfiles

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
  print_cyan " ___      _    __ _ _        "
  print_cyan "|   \ ___| |_ / _(_) |___ ___"
  print_cyan "| |) / _ \  _|  _| | / -_|_-<"
  print_cyan "|___/\___/\__|_| |_|_\___/__/"
}

function print_recap() {
  clear
  banner

  RESULT=

  if [ ! -z "$INSTALL_DONE" ]; then RESULT="${RESULT}${INSTALL_DONE}"; fi
  if [ ! -z "$INSTALL_IN_PROGRESS" ]; then RESULT="${RESULT}${INSTALL_IN_PROGRESS}"; fi

  if [ ! -z "$RESULT" ]; then echo -e "$RESULT"; fi

}

function get_command_path() {
  local SERVICE=$1
  echo $(find $INSTALL_SCRIPTS_PATH -type f -name "*_$SERVICE.sh")
}

function run_service_install() {
  local SERVICE=$1
  CMD=$(get_command_path $SERVICE)
  INSTALL_IN_PROGRESS="[ $(print_yellow "$SERVICE") ]"
  print_recap

  $CMD

  hide_cursor
  echo -ne "\npress key to continue..."
  read -d'' -s -n1
  INSTALL_IN_PROGRESS=
  show_cursor
}

function get_available_services() {
  local ALL_SERVICES=$(find $INSTALL_SCRIPTS_PATH -name "*.sh" -type f -exec bash -c 'basename $0' {} \; | sort)
  ALL_SERVICES=$(echo $ALL_SERVICES | sed "s/\.sh//g" | sed "s/[0-9][0-9][0-9]_//g")
  echo $ALL_SERVICES
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
    if [ -f "$(get_command_path $2)" ]; then
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
