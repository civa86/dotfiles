# ENVIRONMENT
export CLICOLOR=1
export GPG_TTY=$(tty)
export NVM_DIR=~/.nvm

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="git verbose"

# LANGUAGE
export LANG="en_US.UTF-8"

# PAGER
export PAGER=cat
export LESS=FX

# COLORS
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
COLOR_NONE="\033[0m"

# PYTHON POETRY
export POETRY_VIRTUALENVS_CREATE=true
export POETRY_VIRTUALENVS_IN_PROJECT=true