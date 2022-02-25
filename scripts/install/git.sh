#!/usr/bin/env bash

set -e

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))

GIT_CONFIG=$HOME/.gitconfig
GIT_CONFIG_PERSONAL=$HOME/.gitconfig-personal
GIT_CONFIG_WORK=$HOME/.gitconfig-work
GIT_IGNORE_GLOBAL=$HOME/.gitignore_global

rm -rf $GIT_CONFIG $GIT_CONFIG_PERSONAL $GIT_CONFIG_WORK $GIT_IGNORE_GLOBAL

ln -s $BASE_PATH/.gitconfig $GIT_CONFIG
ln -s $BASE_PATH/.gitconfig-personal $GIT_CONFIG_PERSONAL
ln -s $BASE_PATH/.gitconfig-work $GIT_CONFIG_WORK
ln -s $BASE_PATH/.gitignore_global $GIT_IGNORE_GLOBAL

echo -e "[ $(print_green "OK") ] GIT configuration applied."
