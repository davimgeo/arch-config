#!/bin/bash

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

function error() {
  local text="$1"
  printf "%b %s\n" "$FAILED" "$text"
  exit 1
}

function move_config() {
  NVIM_DIR="$HOME/.config"

  echo -n "Do you want to move nvim to $NVIM_DIR? (Y/N): "
  read confirm_nvim

  if [[ "$confirm_nvim" =~ ^([yY]|[yY][eE][sS])$ ]]; then
      cp -r dots/nvim "$NVIM_DIR" || error "Could not move nvim to $NVIM_DIR"
  else
      echo "Skipping moving nvim"
  fi

  printf "%b Copied neovim sucessfully\n" "$OK"


  ZSH_DIR="$HOME"

  echo -n "Do you want to move .zshrc to $ZSH_DIR? (Y/N): "
  read confirm_zsh

  if [[ "$confirm_zsh" =~ ^([yY]|[yY][eE][sS])$ ]]; then
      cp dots/.zshrc "$ZSH_DIR" || error "Could not move zshrc to $ZSH_DIR"
  else
      echo "Skipping moving zshrc"
  fi

  printf "%b Copied .zshrc sucessfully\n" "$OK"
}

move_config
