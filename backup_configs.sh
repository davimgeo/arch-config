#!/bin/bash
# *****************
# Backup dotfiles
# *****************

# array of configs in .config dir 
CONFIG_DIRS=(
  i3 nvim alacritty
)

# array of configs in home dir
HOME_DIRS=(
  .zshrc .zprofile .xinitrc
)

function error() {
  local text="$1"
  printf "%b %s\n" "$FAILED" "$text"
  exit 1
}

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

function backup_zsh()
{
  echo -n "Do you want to backup zsh? (Y/N): "
  read confirm_backup

  if [[ $confirm_backup == [nN] || $confirm_backup == [nN][oO] ]]; then
      echo "Skipping zsh backup..."
      return
  else
      echo "Continuing..."
  fi

  printf "Copying zsh into arch_config/dots...\n"
  cp -r ~/.zshrc ~/arch-config/dots/ || error "%b Copying zsh into arch_config/dots failed\n" 

  printf "%b Copied zsh into arch_config successfully.\n" "$OK"
}

function backup_nvim()
{
  echo -n "Do you want to backup nvim? (Y/N): "
  read confirm_backup

  if [[ $confirm_backup == [nN] || $confirm_backup == [nN][oO] ]]; then
      echo "Skipping nvim backup..."
      return
  else
      echo "Continuing..."
  fi

  printf "Copying nvim into arch_config...\n"
  cp -r ~/.config/nvim/ ~/arch-config/dots/ || error "%b Copying nvim into arch_config failed\n" 

  printf "%b Copied nvim into arch_config successfully.\n" "$OK"
}

backup_zsh
backup_nvim
