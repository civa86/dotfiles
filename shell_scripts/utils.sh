#!/usr/bin/env bash

# COLORS

RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
COLOR_RESET="\033[0m"

# FUNCTIONS

function separator() {
    printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -
}

function parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/ "
}

function current_version () {
    node -p -e "require('./package.json').version"
}

function git_flow_master_branch () {
    git config gitflow.branch.master
}

function git_flow_dev_branch () {
    git config gitflow.branch.develop
}

function git_flow_release_prefix () {
    git config gitflow.prefix.release
}

function print_error() {
    echo -e $RED"Error"$COLOR_RESET
    echo -e "\t$1"
    if [ ! -z "$2" ]; then
        echo -e $GREEN"Hint"$COLOR_RESET
        echo -e "\t$2"
    fi
    echo -e "\n"
    exit 1
}

function is_software_installed() {
    if ! [ -x "$(command -v $1)" ]; then
        print_error "$1 is not installed" "$2"
    fi
}

function is_file_present() {
    if [ ! -f $1 ]; then
        print_error "`basename $1` file not found" "$2"
    fi
}

function is_directory_present() {
    if [ ! -d $1 ]; then
        print_error "folder $1 not found" "$2"
    fi
}

function is_git_flow() {
    local DEV_BRANCH=`git_flow_dev_branch`
    local MASTER_BRANCH=`git_flow_master_branch`

    if [ -z "$DEV_BRANCH" ]; then
        print_error "git-flow not ready" "Run command: git flow init"
    fi

    if [ -z "$MASTER_BRANCH" ]; then
        print_error "git-flow not ready" "Run command: git flow init"
    fi
}

function is_in_git_flow_dev_branch() {
    local DEV_BRANCH=`git_flow_dev_branch`
    local CURRENT_BRANCH=`parse_git_branch`

    if [ "$CURRENT_BRANCH" != "$DEV_BRANCH" ]
    then
        print_error "you are in $YELLOW$CURRENT_BRANCH$COLOR_RESET while you should be in $CYAN$DEV_BRANCH$COLOR_RESET" "Run command: git checkout $DEV_BRANCH"
    fi
}

function is_in_git_flow_release_branch() {
    local RELEASE_PREFIX=`git_flow_release_prefix`
    local CURRENT_BRANCH=`parse_git_branch`

    if [[ ! $CURRENT_BRANCH =~ $RELEASE_PREFIX ]]; then
        print_error "you are in $YELLOW$CURRENT_BRANCH$COLOR_RESET while you should in a branch with prefix $CYAN$RELEASE_PREFIX$COLOR_RESET"
    fi
}

function is_git_status_clean() {
    local GIT_STATUS=`git status --porcelain`

    if [ ! -z "$GIT_STATUS" ]
    then
        print_error "You have to stage and commit all changes" "Run command: git add .\n\tRun command: git commit -m <COMMIT_MESSAGE>"
    fi
}

function is_valid_sem_version() {
    local SEMVER_REGEX="^[0-9]+\.[0-9]+\.[0-9]+$"
    if [[ ! $1 =~ $SEMVER_REGEX ]]; then
        print_error "Release number not valid" "Version Number is based on Semantic Versioning 2.0.0\n\tPlease visit: https://semver.org/"
    fi
}

function version_gt () {
    test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1";
}

function is_new_release () {
    if [ "$1" == $2 ]
    then
        print_error "version $1 already in place"
    fi

    if version_gt $2 $1;
    then
        print_error "version $YELLOW$1$COLOR_RESET must be grater than current $CYAN$2$COLOR_RESET"
    fi
}

function git_has_remote () {
    local REMOTE=`git remote show`

    if [ -z "$REMOTE" ]; then
        echo 0
    else
        echo 1
    fi
}