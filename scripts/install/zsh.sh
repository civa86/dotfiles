#!/usr/bin/env bash

set -e

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
OMZ_PATH=$HOME/.oh-my-zsh

LABEL="Oh-My-Zsh"
if [ ! -d $OMZ_PATH ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo -e "[ $(print_green "OK") ] $LABEL installed."
else
  echo -e "[ $(print_blue "SKIP") ] $LABEL already installed."
fi

LABEL="Syntax Highlighting Plugin"
if [ ! -d ${ZSH_CUSTOM:-$OMZ_PATH/custom}/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$OMZ_PATH/custom}/plugins/zsh-syntax-highlighting
  echo -e "[ $(print_green "OK") ] $LABEL installed."
else
  echo -e "[ $(print_blue "SKIP") ] $LABEL already installed."
fi

LABEL="Better NPM Completion Plugin"
if [ ! -d ${ZSH_CUSTOM:-$OMZ_PATH/custom}/plugins/zsh-better-npm-completion ]; then
  git clone https://github.com/lukechilds/zsh-better-npm-completion ${ZSH_CUSTOM:-$OMZ_PATH/custom}/plugins/zsh-better-npm-completion
  echo -e "[ $(print_green "OK") ] $LABEL installed."
else
  echo -e "[ $(print_blue "SKIP") ] $LABEL already installed."
fi

LABEL="Git Flow Completion Plugin"
if [ ! -d ${ZSH_CUSTOM:-$OMZ_PATH/custom}/plugins/git-flow-completion ]; then
  git clone https://github.com/bobthecow/git-flow-completion ${ZSH_CUSTOM:-$OMZ_PATH/custom}/plugins/git-flow-completion
  echo -e "[ $(print_green "OK") ] $LABEL installed."
else
  echo -e "[ $(print_blue "SKIP") ] $LABEL already installed."
fi

LABEL="PowerLevel10k Theme"
if [ ! -d ${ZSH_CUSTOM:-$OMZ_PATH/custom}/themes/powerlevel10k ]; then
  git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$OMZ_PATH/custom}/themes/powerlevel10k
  echo -e "[ $(print_green "OK") ] $LABEL installed."
else
  echo -e "[ $(print_blue "SKIP") ] $LABEL already installed."
fi

rm -rf $HOME/.p10k.zsh
ln -s $BASE_PATH/.p10k.zsh $HOME/.p10k.zsh

rm -rf $HOME/.zshrc.pre*
rm -rf $HOME/.zshrc
ln -s $BASE_PATH/.zshrc $HOME/.zshrc

echo -e "[ $(print_green "OK") ] ZSH configuration applied."
