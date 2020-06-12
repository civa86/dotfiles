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

zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

source $ZSH/oh-my-zsh.sh
source $DOTFILES/utils/aliases.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
