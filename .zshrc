export DOTFILES=$HOME/Workspace/civa86/dotfiles

source $DOTFILES/utils/env.sh
source $DOTFILES/utils/path.sh
source $DOTFILES/utils/zsh-env.sh

plugins=(
  aws
  git
  git-flow
  git-prompt
  dotenv
  docker
  docker-compose
  kubectl
  nvm
  npm
  yarn
  terraform
)

source $ZSH/oh-my-zsh.sh
source $DOTFILES/utils/aliases.sh







