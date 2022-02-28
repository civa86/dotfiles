#!/usr/bin/env bash

if [ -z "$DOTFILES_HOME" ]; then echo "dotfiles not found!" && exit 1; fi
if [ ! -d "$DOTFILES_HOME/scripts/utils" ]; then echo "dotfiles utils folder not found!" && exit 1; fi

for SCRIPT in $DOTFILES_HOME/scripts/utils/*.sh; do
  source $SCRIPT
done
