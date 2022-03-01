#!/usr/bin/env bash

# COLORS

BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function print_black() {
  echo -e $BLACK"$1"$COLOR_RESET
}

function print_red() {
  echo -e $RED"$1"$COLOR_RESET
}

function print_green() {
  echo -e $GREEN"$1"$COLOR_RESET
}

function print_yellow() {
  echo -e $YELLOW"$1"$COLOR_RESET
}

function print_cyan() {
  echo -e $BLUE"$1"$COLOR_RESET
}

function print_magenta() {
  echo -e $MAGENTA"$1"$COLOR_RESET
}

function print_cyan() {
  echo -e $CYAN"$1"$COLOR_RESET
}

function print_white() {
  echo -e $WHITE"$1"$COLOR_RESET
}

function print_sequence() {
  local CHAR=$1
  local COLS=120
  if [ -t 1 ]; then
    COLS=$(tput cols)
  fi
  printf '%*.0s\n' $COLS "" | tr " " $CHAR
}

function separator() {
  print_sequence "-"
}

function print_error() {
  echo -e "[ $(print_red "ERROR") ]"
  echo -e "\t$1"
  if [ ! -z "$2" ]; then
    echo -e "[ $(print_green "HINT") ]"
    echo -e "\t$2"
  fi
  echo -e "\n"
  exit 1
}

function delete_upper_line() {
  echo -ne "\033[F"
  echo -ne "\033[2K"
}

function hide_cursor() {
  echo -en "\033[?25l"
}

function show_cursor() {
  echo -en "\033[?25h"
}

function hide_input_characters() {
  stty -echo
}

function show_input_characters() {
  stty echo
}

function ctrl_c() {
  show_cursor
  show_input_characters
  exit 0
}

# select_box
# params:
#   1 - string: list of choices space separated ("opt_1 opt_2 opt_3")
# return:
# selected choice will be stored in $SELECT_BOX_CHOICE variable
function select_box() {
  local LIST=("$@")
  local CHOICE=0
  local LOOP=1
  local LIST_LENGTH=${#LIST[@]}
  local LAST_INDEX=$(echo "$LIST_LENGTH - 1" | bc -l)

  SELECT_BOX_CHOICE=

  hide_input_characters
  hide_cursor

  while [ $LOOP -eq 1 ]; do
    # tput clear

    for i in ${!LIST[@]}; do
      if [ $CHOICE -eq $i ]; then echo -en $YELLOW" ▸ "$COLOR_RESET; else echo -en "   "; fi
      echo "${LIST[$i]}"
    done

    read -n1 c
    case "$c" in
    $'')
      LOOP=0
      ;;
    $'\033')
      read -t1 -n2 r
      case "$r" in
      '[A')
        if [ $CHOICE -gt 0 ]; then
          CHOICE=$(echo $CHOICE - 1 | bc -l)
        else
          CHOICE=$LAST_INDEX
        fi
        ;;
      '[B')
        if [ $CHOICE -lt $LAST_INDEX ]; then
          CHOICE=$(echo $CHOICE + 1 | bc -l)
        else
          CHOICE=0
        fi
        ;;
      esac
      ;;
    esac

    for i in ${!LIST[@]}; do
      delete_upper_line
    done

  done

  show_input_characters
  show_cursor

  SELECT_BOX_CHOICE=${LIST[$CHOICE]}
}
