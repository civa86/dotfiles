#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

source $SCRIPTPATH/../utils.sh

BASE_PATH=$(dirname $(dirname $SCRIPTPATH))
CLAUDE_SRC=$BASE_PATH/claude
CLAUDE_PATH=$HOME/.claude

mkdir -p $CLAUDE_PATH

while IFS= read -r -d '' FILE; do
  REL=${FILE#$CLAUDE_SRC/}
  TARGET=$CLAUDE_PATH/$REL
  mkdir -p "$(dirname $TARGET)"
  rm -f "$TARGET"
  ln -s "$FILE" "$TARGET"
  echo -e "[ $(print_green "OK") ] linked $REL."
done < <(find $CLAUDE_SRC -type f -print0)

echo -e "[ $(print_green "OK") ] claude configuration applied."
