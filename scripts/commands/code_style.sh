#!/usr/bin/env bash

#completion_desc::Copy code style rules in current directory

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
AVAILABLE_RULES="prettier bash python"
RULE=
RULE_PATH=

# FUNCTIONS
function usage() {
  echo "DESCRIPTION"
  echo -e "\tCopy code style rules in current directory"
  echo "SYNOPSIS"
  echo -e "\tdot code_style [--rule rule_name]"
  echo "OPTIONS"
  echo -e "\t-r, --rule  (string)  Name of the rule to copy"
  echo "RULES"
  for R in $AVAILABLE_RULES; do
    echo -e "\t- $R"
  done

}

# PARSE ARGUMENTS
if [ "$1" == "help" ]; then
  usage && exit 0
else
  RULE=$1
fi

# EXECUTION
trap ctrl_c INT

clear

banner "CodeStyle"

if [ -z "$RULE" ]; then
  select_box $AVAILABLE_RULES
  RULE=$SELECT_BOX_CHOICE
fi

clear

banner "CodeStyle"

case $RULE in
prettier)
  RULE_PATH=$BASE_PATH/.prettierrc
  ;;
bash)
  RULE_PATH=$BASE_PATH/.editorconfig
  ;;
python)
  RULE_PATH=$BASE_PATH/.pep8
  ;;
*)
  usage
  echo -e "\n[ $(print_red "ERROR") ] Invalid rule: $RULE."
  exit 1
  ;;
esac

cp $RULE_PATH $PWD/
echo -e "[ $(print_green "OK") ][ $(print_magenta $RULE) ] rules copied."
