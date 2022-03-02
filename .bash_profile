export DOTFILES_HOME=$HOME/dotfiles

source $DOTFILES_HOME/env/env.sh
source $DOTFILES_HOME/env/aliases.sh
source $DOTFILES_HOME/env/path.sh

# BASH COMPLETION
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
