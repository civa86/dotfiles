#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

for SCRIPT in $SCRIPTPATH/../utils/*.sh; do
  source $SCRIPT
done
