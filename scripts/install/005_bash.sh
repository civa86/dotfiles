#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))

# COPY BASH PROFILE
rm -rf $HOME/.bash_profile
ln -s $BASE_PATH/.bash_profile $HOME/.bash_profile

# INSTALL COMPLETION
is_software_installed brew

COMPLETION_FOLDER=$(brew --prefix)/etc/bash_completion.d

is_directory_present $COMPLETION_FOLDER "Run command: brew install bash-completion"

for SCRIPT in $BASE_PATH/bash_completion/*; do
  rm -f $COMPLETION_FOLDER/$(basename $SCRIPT)
  ln -s $SCRIPT $COMPLETION_FOLDER/$(basename $SCRIPT)
done

echo -e "[ $(print_green "OK") ] BASH configuration applied."
