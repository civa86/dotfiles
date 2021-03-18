source "`dirname $0`"/scripts/utils.sh

if ! command -v brew &> /dev/null
then
    echo $CYAN"[HOMEBREW] Install"$COLOR_RESET
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# SHELL
brew install bash-completion

# TOOLS
brew install rename
brew install git-flow
brew install jmeter

# LANGS
brew install ruby
brew install python

# DEV
brew install yarn

# DEVOPS
brew install kubectl
brew install warrensbox/tap/tfswitch
brew install packer
