# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES_HOME=$HOME/dotfiles

source $DOTFILES_HOME/env/env.sh
source $DOTFILES_HOME/env/path.sh
source $DOTFILES_HOME/env/zsh-env.sh

plugins=(
  yarn
  colored-man-pages
  cp
  aws
  docker
  docker-compose
  docker-machine
  nvm
  terraform
  poetry
)

for CUSTOM_PLUGIN in $ZSH/custom/plugins/*; do
  CUSTOM_PLUGIN_NAME=$(basename $CUSTOM_PLUGIN)
  plugins+=("$CUSTOM_PLUGIN_NAME")
done

# SSH / SCP autocomplete
zstyle ':completion:*:(ssh|scp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp):*' users $users

source $ZSH/oh-my-zsh.sh
source $DOTFILES_HOME/env/aliases.sh

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