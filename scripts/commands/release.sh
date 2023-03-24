#!/usr/bin/env bash

#completion_desc::New project release

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
CLOSE_RELEASE=
ARGUMENTS=

# FUNCTIONS
function usage() {
  echo "DESCRIPTION"
  echo -e "\tNew project release"
  echo "SYNOPSIS"
  echo -e "\tdot release [--close] <version>"
  echo "ARGUMENTS"
  echo -e "\t- version  (string)  SEM versioning compliant number"
  echo "OPTIONS"
  echo -e "\t-c, --close  (string)  Close the release at the end"
}

function release_finish_output() {
  delete_upper_line
  delete_upper_line
  echo -e "[ $(print_cyan "RELEASE") ][ $(print_green $RELEASE_NUM) ]"
}

function close_release() {
  git flow release finish -m "v$RELEASE_NUM" "v$RELEASE_NUM" &>/dev/null
  REMOTE=$(git_has_remote)
  if [ $REMOTE -eq 1 ]; then
    git push --all &>/dev/null
    git push --tags &>/dev/null
    FINAL_MESSAGE=$(echo -e "[ $(print_green "OK") ] pushed to origin.")
  else
    FINAL_MESSAGE=$(echo -e "[ $(print_cyan "SKIP") ] no remote origin.")
  fi
  release_finish_output
  echo -e "$FINAL_MESSAGE\n"
}

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  --close | -c)
    CLOSE_RELEASE=1
    shift # past argument
    shift # past value
    ;;
  -* | --*=) # unsupported flags
    usage
    echo -e "\n[ $(print_red "ERROR") ] Invalid options."
    exit 1
    ;;
  *) # preserve positional arguments
    ARGUMENTS="$ARGUMENTS $1"
    shift
    ;;
  esac
done

ARGS_COUNT=$(echo $ARGUMENTS | awk -F" " '{print NF}')
if [ ! $ARGS_COUNT -eq 1 ]; then
  usage
  echo -e "\n[ $(print_red "ERROR") ] Required just one argument."
  exit 1
fi
ARG=$(echo $ARGUMENTS | awk -F" " '{print $NF}')
if [ "$ARG" == "help" ]; then usage && exit 0; fi

clear

banner "Release"

RELEASE_NUM=$ARG

check_software "git" "Please visit: https://git-scm.com/"

is_valid_sem_version $RELEASE_NUM

PACKAGE_TYPE=$(get_package_type)
if [ -z $PACKAGE_TYPE ]; then print_error "Invalid Package" "Release can work only with npm or poetry packages"; fi

is_git_flow

is_in_git_flow_dev_branch

is_git_status_clean

echo -e "[ $(print_cyan "PACKAGE") ][ $(print_magenta $PACKAGE_TYPE) ]"

CURRENT_VERSION="$(get_package_version $PACKAGE_TYPE)"
if [ -z $CURRENT_VERSION ]; then print_error "Invalid Package" "Release can work only with npm or poetry packages"; fi

is_valid_release $RELEASE_NUM $CURRENT_VERSION

if [ "$RELEASE_NUM" == "$CURRENT_VERSION" ]; then
  echo -e "[ $(print_cyan "VERSION") ][ $(print_yellow $RELEASE_NUM) ]"
else
  echo -e "[ $(print_cyan "VERSION") ][ $(print_magenta $CURRENT_VERSION) -> $(print_yellow $RELEASE_NUM) ]"
fi

read -p "Do you want to proceed? [y/N] " CONFIRM_RELEASE
CONFIRM_RELEASE=${CONFIRM_RELEASE:-N}
case "$CONFIRM_RELEASE" in
[yY])
  delete_upper_line

  git flow release start "v$RELEASE_NUM" &>/dev/null
  update_version $RELEASE_NUM $PACKAGE_TYPE &>/dev/null
  git add . &>/dev/null
  git commit -m "release candidate v$RELEASE_NUM" &>/dev/null

  if [ -z "$CLOSE_RELEASE" ]; then
    read -p "Do you want to close the release? [Y/n] " CONFIRM_CLOSE_RELEASE
    CONFIRM_CLOSE_RELEASE=${CONFIRM_CLOSE_RELEASE:-Y}
    case "$CONFIRM_CLOSE_RELEASE" in
    [yY])
      delete_upper_line
      close_release
      ;;
    *)
      release_finish_output
      echo -e "[ $(print_cyan "TODO") ]"
      echo -e "\tDon't foreget to push $(parse_git_branch)"
      echo -e "[ $(print_green "HINT") ]"
      echo -e "\tRun command: git push --set-upstream origin $(parse_git_branch)\n"
      ;;
    esac
  else
    close_release
  fi
  ;;
*)
  delete_upper_line
  echo -e "[ $(print_red "CANCEL") ] release aborted.\n"
  ;;
esac
