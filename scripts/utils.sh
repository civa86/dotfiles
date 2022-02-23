#!/usr/bin/env bash

if [ -z "$DOTFILES" ]; then echo "dotfiles not found!" && exit 1; fi
if [ ! -d "$DOTFILES/scripts/utils" ]; then echo "dotfiles utils folder not found!" && exit 1; fi

for SCRIPT in $DOTFILES/scripts/utils/*.sh; do
  source $SCRIPT
done
