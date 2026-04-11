#!/bin/bash

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

OUTPUT_PATH="$HOME/arch-config/dots/"

function error() {
  local text="$1"
  printf "%b %s\n" "$FAILED" "$text"
  exit 1
}

function copy() {
  local SRC="$1"
  local NAME="$2"
  local confirm

  echo -n "Do you want to backup $NAME? (Y/N): "
  read confirm

  if [[ "$confirm" =~ ^([yY]|[yY][eE][sS])$ ]]; then
      cp -r "$SRC" "$OUTPUT_PATH" || error "Copying $NAME failed"
      printf "%b Copied $NAME successfully\n" "$OK"
  else
      echo "Skipping $NAME..."
  fi
}

function backup() {
  local -n SOURCES_REF=$1
  local -n NAMES_REF=$2

  for i in "${!SOURCES_REF[@]}"; do
    copy "${SOURCES_REF[$i]}" "${NAMES_REF[$i]}"
  done
}

SOURCES=(
  "$HOME/.zshrc"
  "$HOME/.config/nvim"
  "$HOME/.config/i3"
  "$HOME/.config/picom.conf"
  "$HOME/.config/kitty"
  "$HOME/.config/polybar"
)

NAMES=(
  "zsh"
  "nvim"
  "i3"
  "picom"
  "kitty"
  "polybar"
)

backup SOURCES NAMES
