#!/usr/bin/env sh

source "`dirname $0`"/scripts/utils.sh

if [ ! -f ~/.nvm/nvm.sh ]
then
    echo $CYAN"[nvm] Install"$COLOR_RESET
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
else
    echo $YELLOW"[SKIP] nvm already installed!"$COLOR_RESET
fi

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

echo $CYAN"[nvm] Choose Version"$COLOR_RESET
nvm ls

if command -v node &> /dev/null
then
    CURRENT_NODE=`node --version`
    NODE_V=$CURRENT_NODE
fi
CURRENT_NODE=${CURRENT_NODE:-}

read -p "Node Version? [$CURRENT_NODE] " NODE_V
NODE_V=${NODE_V:-$CURRENT_NODE}

if [ -z $NODE_V ]
then
    echo $RED"[ERROR] Node Version required!"$COLOR_RESET
    exit 1
fi
echo $CYAN"[NODE VERSION] $NODE_V"$COLOR_RESET
nvm install $NODE_V

read -p "Set $NODE_V as default version? [Y/n] " DEFAULT_NODE
DEFAULT_NODE=${DEFAULT_NODE:-Y}
case "$DEFAULT_NODE" in
    [yY])
        nvm alias default $NODE_V
        echo $GREEN"[OK] Set default version to $NODE_V"$COLOR_RESET
        ;;
    *) echo $YELLOW"[SKIP] Set default version to $NODE_V"$COLOR_RESET;;
esac

npm i -g \
    npm-check-updates \
    @vue/cli \
    create-react-app \
    aks \
    firebase-tools \
    serverless \
    wscat \
    nodemon