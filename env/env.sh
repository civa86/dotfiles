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

# PYTHON POETRY
export SETUPTOOLS_USE_DISTUTILS=stdlib
export POETRY_VIRTUALENVS_CREATE=true
export POETRY_VIRTUALENVS_IN_PROJECT=true

# HOMEBREW
export HOMEBREW_NO_AUTO_UPDATE=1

# APPLE SILICON JPEG
if [ -d /opt/homebrew/opt/jpeg ]; then
  export LDFLAGS="-L/opt/homebrew/opt/jpeg/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/jpeg/include"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/jpeg/lib/pkgconfig"
fi
