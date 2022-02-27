#!/usr/bin/env bash

NPM_PACKAGE_FILE="package.json"
POETRY_PACKAGE_FILE="pyproject.toml"

function parse_git_branch() {
  git branch 2>/dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/ "
}

function current_version() {
  case $1 in
  npm)
    node -p -e "require(\"$PWD/$NPM_PACKAGE_FILE\").version"
    ;;
  poetry)
    cat $PWD/$POETRY_PACKAGE_FILE | grep "version" | awk -F '=' '{print $NF}' | sed 's/"//g'
    ;;
  *) ;;
  esac
}

function git_flow_master_branch() {
  git config gitflow.branch.master
}

function git_flow_dev_branch() {
  git config gitflow.branch.develop
}

function git_flow_release_prefix() {
  git config gitflow.prefix.release
}

function get_package_type() {
  if [ -f $PWD/$NPM_PACKAGE_FILE ]; then
    check_software "npm" "Please visit: https://nodejs.org"
    echo "npm"
  elif [ -f $PWD/$POETRY_PACKAGE_FILE ]; then
    check_software "poetry" "Please visit: https://python-poetry.org/"
    echo "poetry"
  fi
}

function is_git_flow() {
  local DEV_BRANCH=$(git_flow_dev_branch)
  local MASTER_BRANCH=$(git_flow_master_branch)

  if [ -z "$DEV_BRANCH" ]; then
    print_error "git-flow not ready" "Run command: git flow init"
  fi

  if [ -z "$MASTER_BRANCH" ]; then
    print_error "git-flow not ready" "Run command: git flow init"
  fi
}

function is_in_git_flow_dev_branch() {
  local DEV_BRANCH=$(git_flow_dev_branch)
  local CURRENT_BRANCH=$(parse_git_branch)

  if [ "$CURRENT_BRANCH" != "$DEV_BRANCH" ]; then
    print_error "you are in $YELLOW$CURRENT_BRANCH$COLOR_RESET while you should be in $CYAN$DEV_BRANCH$COLOR_RESET" "Run command: git checkout $DEV_BRANCH"
  fi
}

function is_in_git_flow_release_branch() {
  local RELEASE_PREFIX=$(git_flow_release_prefix)
  local CURRENT_BRANCH=$(parse_git_branch)

  if [[ ! $CURRENT_BRANCH =~ $RELEASE_PREFIX ]]; then
    print_error "you are in $YELLOW$CURRENT_BRANCH$COLOR_RESET while you should in a branch with prefix $CYAN$RELEASE_PREFIX$COLOR_RESET"
  fi
}

function is_git_status_clean() {
  local GIT_STATUS=$(git status --porcelain)

  if [ ! -z "$GIT_STATUS" ]; then
    print_error "You have to stage and commit all changes" "Run command: git add .\n\tRun command: git commit -m <COMMIT_MESSAGE>"
  fi
}

function is_valid_sem_version() {
  local SEMVER_REGEX="^[0-9]+\.[0-9]+\.[0-9]+$"
  if [[ ! $1 =~ $SEMVER_REGEX ]]; then
    print_error "Release number not valid" "Version Number is based on Semantic Versioning 2.0.0\n\tPlease visit: https://semver.org/"
  fi
}

function version_gt() {
  test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"
}

function is_new_release() {
  if [ "$1" == $2 ]; then
    print_error "version $1 already in place"
  fi

  if version_gt $2 $1; then
    print_error "version $YELLOW$1$COLOR_RESET must be grater than current $CYAN$2$COLOR_RESET"
  fi
}

function git_has_remote() {
  local REMOTE=$(git remote show)

  if [ -z "$REMOTE" ]; then
    echo 0
  else
    echo 1
  fi
}

function update_version() {
  case $2 in
  npm)
    npm --no-git-tag-version version $1
    ;;
  poetry)
    poetry version $1
    ;;
  *)
    print_error "Error updating version"
    ;;
  esac
}
