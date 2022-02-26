#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
VIM_PATH=$HOME/.vim
VIM_PROFILE_PATH=$HOME/.vimrc

if [ ! -f $VIM_PATH/autoload/plug.vim ]; then
  curl -fLo $VIM_PATH/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo -e "[ $(print_green "OK") ] vim-plug installed."
else
  echo -e "[ $(print_blue "SKIP") ] vim-plug already installed."
fi

rm -rf $VIM_PROFILE_PATH
ln -s $BASE_PATH/.vimrc $VIM_PROFILE_PATH
vim +PlugInstall +qall

echo -e "[ $(print_green "OK") ] VIM configuration applied."
