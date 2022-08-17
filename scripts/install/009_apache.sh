#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
VHOST_PATH=$HOME/vhosts

mkdir -p $VHOST_PATH
cat $BASE_PATH/apache/000-default.conf | sed "s|HOME|$HOME|" >$VHOST_PATH/000-default.conf
echo -e "[ $(print_green "OK") ] vhosts configuration applied."

DOCUMENT_ROOT=$(cat $VHOST_PATH/000-default.conf | grep DocumentRoot | awk -F" " '{print $NF}' | sed 's|"||g')
# cp $BASE_PATH/apache/info.php $DOCUMENT_ROOT/info.php

echo -e "[ $(print_yellow "WARN") ] Super User required!"
sudo bash -c "cat $BASE_PATH/apache/httpd.conf | sed -e 's|HOME|$HOME|g' -e 's|WWW_USER|$USER|g' >/etc/apache2/httpd.conf"
echo -e "[ $(print_green "OK") ] apache configuration applied."

apachectl configtest
if [ $? -eq 0 ]; then
  sudo apachectl restart
  echo -e "[ $(print_green "OK") ] apache restarted."
else
  echo -e "[ $(print_red "ERROR") ] apache configuration seems wrong, check it and re-run."
fi
