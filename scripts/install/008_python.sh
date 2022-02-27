#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

check_software pip3
check_software python3

if [ $(is_software_installed virtualenv) -eq 0 ]; then
  echo -e "[ $(print_yellow "WARN") ] Super User required!"
  sudo pip3 install virtualenv
  echo -e "[ $(print_green "OK") ] virtualenv installed."
else
  echo -e "[ $(print_blue "SKIP") ] virtualenv already installed."
fi

if [ $(is_software_installed poetry) -eq 0 ]; then
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
  echo -e "[ $(print_green "OK") ] poetry installed."
else
  echo -e "[ $(print_blue "SKIP") ] poetry already installed."
fi
