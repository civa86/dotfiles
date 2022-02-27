#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
NVM_DIR="$HOME/.nvm"
NVM_SCRIPT="$NVM_DIR/nvm.sh"
GLOBAL_DEPS="npm-check-updates @nestjs/cli @vue/cli create-react-app firebase-tools serverless wscat nodemon"

if [ ! -f $NVM_SCRIPT ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  echo -e "[ $(print_green "OK") ] NVM installed."
else
  echo -e "[ $(print_blue "SKIP") ] NVM already installed."
fi

[ -s "$NVM_SCRIPT" ] && \. "$NVM_SCRIPT" # This loads nvm

echo -e "[ $(print_yellow "Available Versions") ]"

nvm ls | egrep "lts(.*)v"

if [ $(is_software_installed node) -eq 1 ]; then
  CURRENT_NODE=$(node --version)
  NODE_V=$CURRENT_NODE
fi
CURRENT_NODE=${CURRENT_NODE:-}

read -p "Select Version: [$CURRENT_NODE] " NODE_V
NODE_V=${NODE_V:-$CURRENT_NODE}

if [ -z $NODE_V ]; then
  print_red "No version selected"
  exit 1
fi

nvm install $NODE_V

read -p "Set $NODE_V as default version? [Y/n] " DEFAULT_NODE
DEFAULT_NODE=${DEFAULT_NODE:-Y}
case "$DEFAULT_NODE" in
[yY])
  nvm alias default $NODE_V
  echo -e "[ $(print_green "OK") ][ $(print_magenta $NODE_V) ] default version."
  ;;
*) echo -e "[ $(print_blue "SKIP") ][ $(print_magenta $NODE_V) ] default version." ;;
esac

INSTALLED_GLOBAL_DEPS=$(npm list -g --json --depth 0)
for DEP in $GLOBAL_DEPS; do
  DEP_INSTALLED=$(jq -r ".dependencies.\"$DEP\"" <<<$INSTALLED_GLOBAL_DEPS)
  if [ "$DEP_INSTALLED" == "null" ]; then
    echo -e "[ $(print_yellow $DEP) ] installing..."
    npm i -g $DEP &>/dev/null
    delete_upper_line
    echo -e "[ $(print_green "OK") ][ $(print_magenta $DEP) ] installed."
  else
    echo -e "[ $(print_blue "SKIP") ][ $(print_magenta $DEP) ] already installed."
  fi
done

read -p "Upgrade any global dependency? [y/N] " GLOBAL_DEPS_UPGRADE
GLOBAL_DEPS_UPGRADE=${GLOBAL_DEPS_UPGRADE:-N}
case "$GLOBAL_DEPS_UPGRADE" in
[yY])
  echo -e "[ $(print_yellow "global deps") ] upgrading..."
  npm update -g &>/dev/null
  delete_upper_line
  echo -e "[ $(print_green "OK") ] global dependencies ugraded."
  ;;
*)
  delete_upper_line
  echo -e "[ $(print_blue "SKIP") ] global dependencies ugrade."
  ;;
esac
