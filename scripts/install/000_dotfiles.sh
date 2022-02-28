#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
WORKSPACE_PATH="$HOME/Workspace"
WORKSPACE_JOB="$WORKSPACE_PATH/reply"
WORKSPACE_PERSONAL="$WORKSPACE_PATH/civa86"

# WORKSPACE
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

# ADDITIONAL FONTS
cp $BASE_PATH/fonts/* ~/Library/Fonts/
echo -e "[ $(print_green "OK") ] fonts installed."

# DOT COMMAND
ln -sf $BASE_PATH/scripts/dot.sh /usr/local/bin/dotfiles
echo -e "[ $(print_green "OK") ] dot command linked."

if [ -d $HOME/.oh-my-zsh ]; then
  mkdir -p $HOME/.oh-my-zsh/plugins/dotfiles
  ln -sf $BASE_PATH/scripts/dot-completion $HOME/.oh-my-zsh/plugins/dotfiles/_dotfiles
  echo -e "[ $(print_green "OK") ] dot completion installed."
else
  echo -e "[ $(print_yellow "SKIP") ] dot completion: oh my zsh not found."
fi
