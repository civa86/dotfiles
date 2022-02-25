#!/usr/bin/env bash

set -e

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

WORKSPACE_PATH="$HOME/Workspace"
WORKSPACE_JOB="$WORKSPACE_PATH/reply"
WORKSPACE_PERSONAL="$WORKSPACE_PATH/civa86"

if [ -d "$WORKSPACE_JOB" ] && [ -d "$WORKSPACE_PERSONAL" ]; then
  echo -e "[ $(print_blue "SKIP") ] all workspaces are already in place."

else
  if [ ! -d "$WORKSPACE_PATH" ]; then
    mkdir -p $WORKSPACE_JOB $WORKSPACE_PERSONAL
    echo -e "[ $(print_green "OK") ] all workspaces created."
  else
    if [ ! -d "$WORKSPACE_JOB" ]; then
      mkdir -p $WORKSPACE_JOB
      echo -e "[ $(print_green "OK") ] job workspace created."
    fi

    if [ ! -d "$WORKSPACE_PERSONAL" ]; then
      mkdir -p $WORKSPACE_PERSONAL
      echo -e "[ $(print_green "OK") ] personal workspace created."
    fi
  fi
fi
