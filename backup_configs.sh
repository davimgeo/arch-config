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

BACKUP_DIR="dots"

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

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
  cp -r ~/.config/nvim/ ~/arch-config/ || { printf "%b Copying nvim into arch_config failed\n" "$FAILED"; exit 1; }

  printf "%b Copied nvim into arch_config successfully.\n" "$OK"
}

backup_nvim
