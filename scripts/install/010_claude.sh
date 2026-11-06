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
done < <(find $CLAUDE_SRC -path $CLAUDE_SRC/skills -prune -o -type f ! -name .DS_Store -print0)

if [ -d "$CLAUDE_SRC/skills" ]; then
  mkdir -p "$CLAUDE_PATH/skills"
  while IFS= read -r -d '' DIR; do
    TARGET=$CLAUDE_PATH/skills/$(basename "$DIR")
    rm -rf "$TARGET"
    ln -s "$DIR" "$TARGET"
    echo -e "[ $(print_green "OK") ] linked skills/$(basename "$DIR")."
  done < <(find $CLAUDE_SRC/skills -mindepth 1 -maxdepth 1 -type d -print0)
fi

echo -e "[ $(print_green "OK") ] claude configuration applied."
