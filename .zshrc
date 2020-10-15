# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES=$HOME/Documents/dotfiles

source $DOTFILES/utils/env.sh
source $DOTFILES/utils/path.sh
source $DOTFILES/utils/zsh-env.sh

plugins=(
  zsh-syntax-highlighting
  zsh-better-npm-completion
  colored-man-pages
  aws
  docker
  docker-compose
  nvm
  terraform
  git-flow-completion
)

# SSH / SCP autocomplete
zstyle ':completion:*:(ssh|scp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp):*' users $users

source $ZSH/oh-my-zsh.sh
source $DOTFILES/utils/aliases.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PROMPT_EOL_MARK=''
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true