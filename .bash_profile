export DOTFILES=$HOME/Documents/dotfiles

source $DOTFILES/utils/env.sh
source $DOTFILES/utils/aliases.sh
source $DOTFILES/utils/path.sh

# BASH COMPLETITION
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PS1
PS1="[\t]\[$GREEN\]\$(__git_ps1 ' [%s]')\[$COLOR_NONE\]\[$CYAN\]\$(__docker_machine_ps1 ' [%s]')\[$COLOR_NONE\] \[$YELLOW\][\w]\[$COLOR_NONE\]\n└─⌘ "

# AWS CLI
if [ -x "$(command -v aws)" ] && [ -x "$(command -v aws_completer)" ]; then
  complete -C '/usr/local/aws/bin/aws_completer' aws
fi

# RUBY rbenv
if which rbenv >/dev/null; then eval "$(rbenv init -)"; fi
