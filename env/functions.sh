# Mega Sync Torrent

function minion-torrent() {
  if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/file.torrent"
    return 1
  fi

  if [ ! -f "$1" ]; then
    echo "Torrent file not found: $1"
    return 1
  fi

  if [[ ! $1 =~ \.torrent$ ]]; then
    echo "Invalid torrent file: $1"
    return 1
  fi

  mega-put $1 /minion_server/torrent/

  rm -rf $1
}

function minion-magnet() {
  if [ -z "$1" ]; then
    echo "Usage: $0 magnet:link"
    return 1
  fi

  local GUID
  GUID="$(uuidgen)"

  local TMP_FILE="/tmp/$GUID.magnet"

  echo "$1" > $TMP_FILE

  mega-put $TMP_FILE /minion_server/magnets/

  rm -rf $TMP_FILE
}

function minion-anime() {
  if [ -z "$1" ]; then
    echo "Usage: $0 http://anime-unity.url"
    return 1
  fi

  local GUID
  GUID="$(uuidgen)"

  local TMP_FILE="/tmp/$GUID.url"

  echo "$1" > $TMP_FILE

  mega-put $TMP_FILE /minion_server/anime/

  rm -rf $TMP_FILE
}
