#!/bin/bash

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

function error() {
  local text="$1"
  printf "%b %s\n" "$FAILED" "$text"
  exit 1
}

function copy() {
  local DIR="$1"
  local PROP="$2"
  local confirm

  echo -n "Do you want to move $PROP to $DIR? (Y/N): "
  read confirm

  if [[ "$confirm" =~ ^([yY]|[yY][eE][sS])$ ]]; then
      cp -r "dots/$PROP" "$DIR" || error "Could not move $PROP to $DIR"
      printf "%b Copied $PROP successfully\n" "$OK"
  else
      echo "Skipping moving $PROP"
  fi
}

function install() {
  local -n DIRS_REF=$1
  local -n PROGRAMS_REF=$2

  for i in "${!PROGRAMS_REF[@]}"; do
    copy "${DIRS_REF[$i]}" "${PROGRAMS_REF[$i]}"
  done
}

DIRS=(
  "$HOME/.config/"
  "$HOME"
  "$HOME/.config/"
  "$HOME/.config"
  "$HOME/.config"
)

PROGRAMS=(
  "nvim" ".zshrc" "i3"
  "polybar" "picom.conf"
)

install "${DIRS[@]}" "${PROGRAMS[@]}"
install DIRS PROGRAMS
