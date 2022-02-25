# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES=$HOME/Documents/dotfiles

source $DOTFILES/env/env.sh
source $DOTFILES/env/path.sh
source $DOTFILES/env/zsh-env.sh

plugins=(
  zsh-syntax-highlighting
  zsh-better-npm-completion
  yarn
  colored-man-pages
  cp
  aws
  docker
  docker-compose
  docker-machine
  nvm
  terraform
  git-flow-completion
)

# SSH / SCP autocomplete
zstyle ':completion:*:(ssh|scp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp):*' users $users

source $ZSH/oh-my-zsh.sh
source $DOTFILES/env/aliases.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PROMPT_EOL_MARK=''
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# twilio autocomplete setup
if [ -x "$(command -v twilio)" ]; then
  TWILIO_AC_ZSH_SETUP_PATH=$HOME/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH;
fi

# groovy home setup
if [ -x "$(command -v groovy)" ]; then
  export GROOVY_HOME=/usr/local/opt/groovy/libexec
fi