#!/usr/bin/env bash

set -e

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
FORMULAE="bash-completion rename git-flow jmeter jq ruby python yarn kubectl warrensbox/tap/tfswitch packer"

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo -e "[ $(print_green "OK") ] Homebrew installed."
else
  echo -e "[ $(print_blue "SKIP") ] Homebrew already installed."
  read -p "Update Homebrew to the latest version? [y/N] " BREW_UPDATE
  BREW_UPDATE=${BREW_UPDATE:-N}
  case "$BREW_UPDATE" in
  [yY])
    brew update
    delete_upper_line
    echo -e "[ $(print_green "OK") ] Homebrew updated."
    ;;
  *)
    delete_upper_line
    echo -e "[ $(print_blue "SKIP") ] Homebrew update."
    ;;
  esac
fi

for F in $FORMULAE; do
  FORMULA_NAME=$(basename $F)
  if brew list $F &>/dev/null; then
    echo -e "[ $(print_blue "SKIP") ][ $(print_magenta $FORMULA_NAME) ] already installed."
  else
    brew install $F
    echo -e "[ $(print_green "OK") ][ $(print_magenta $FORMULA_NAME) ] installed."
  fi
done

read -p "Upgrade any already installed formulae? [y/N] " FORMULAE_UPGRADE
FORMULAE_UPGRADE=${FORMULAE_UPGRADE:-N}
case "$FORMULAE_UPGRADE" in
[yY])
  brew upgrade
  delete_upper_line
  echo -e "[ $(print_green "OK") ] Formulae ugraded."
  ;;
*)
  delete_upper_line
  echo -e "[ $(print_blue "SKIP") ] Formulae ugrade."
  ;;
esac
