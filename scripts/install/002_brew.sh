#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
FORMULAE="bash-completion openssl rename git-flow watchman watch imagemagick jmeter jq ruby python yarn warrensbox/tap/tfswitch packer php"

if [ $(is_software_installed brew) -eq 0 ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo -e "[ $(print_green "OK") ] Homebrew installed."
else
  echo -e "[ $(print_cyan "SKIP") ] Homebrew already installed."
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
    echo -e "[ $(print_cyan "SKIP") ] Homebrew update."
    ;;
  esac
fi

INSTALLED_FORMULAE=$(brew list)
for F in $FORMULAE; do
  FORMULA_NAME=$(basename $F)
  CNT="$(echo $INSTALLED_FORMULAE | grep -c $FORMULA_NAME)"
  if [ $CNT -eq 0 ]; then
    echo -e "[ $(print_yellow $FORMULA_NAME) ] installing..."
    brew install $F &>/dev/null
    delete_upper_line
    echo -e "[ $(print_green "OK") ][ $(print_magenta $FORMULA_NAME) ] installed."
  else
    echo -e "[ $(print_cyan "SKIP") ][ $(print_magenta $FORMULA_NAME) ] already installed."
  fi
done

read -p "Upgrade any already installed formulae? [y/N] " FORMULAE_UPGRADE
FORMULAE_UPGRADE=${FORMULAE_UPGRADE:-N}
case "$FORMULAE_UPGRADE" in
[yY])
  echo -e "[ $(print_yellow formulae) ] upgrading..."
  brew upgrade &>/dev/null
  delete_upper_line
  echo -e "[ $(print_green "OK") ] formulae ugraded."
  ;;
*)
  delete_upper_line
  echo -e "[ $(print_cyan "SKIP") ] formulae ugrade."
  ;;
esac
