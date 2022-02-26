#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))

cp $BASE_PATH/fonts/* ~/Library/Fonts/

echo -e "[ $(print_green "OK") ] fonts installed."
