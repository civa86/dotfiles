# ENVIRONMENT
export CLICOLOR=1
export GPG_TTY=$(tty)
export NVM_DIR=~/.nvm
export DOTFILES=$HOME/Workspace/civa86/dotfiles

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="git verbose"

# LANGUAGE
export LANG="en_US.UTF-8"

# COLORS
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
COLOR_NONE="\033[0m"

# BASH COMPLETITION
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# ALIAS
alias ll='ls -al'
alias gifify='docker run -v $(pwd):/data civa86/gifify-light'
alias dotnet-dev='docker run -it -v $(pwd):/app -p 5000:5000 civa86/dotnet-dev'
alias mysql-start='docker run -d --name mysql-local -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 mysql:5.7'
alias mysql-stop='docker stop mysql-local && docker rm mysql-local'
alias mysql-logs='docker logs -f mysql-local'
alias mongo-start='docker run -d --name mongo-local -p 27017:27017 mongo:4.0'
alias mongo-stop='docker stop mongo-local && docker rm mongo-local'

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PS1
PS1="[\t]\[$GREEN\]\$(__git_ps1 ' [%s]')\[$COLOR_NONE\]\[$CYAN\]\$(__docker_machine_ps1 ' [%s]')\[$COLOR_NONE\] \[$YELLOW\][\w]\[$COLOR_NONE\]\n└─⌘ "

# PATH
#export PATH="$DOTFILES/bash_scripts/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/.rbenv/bin:/Applications/MySQLWorkbench.app/Contents/MacOS:$PATH"
export PATH="$DOTFILES/bash_scripts/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/.rbenv/bin:$PATH"

# RUBY rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
