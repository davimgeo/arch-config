#!/bin/zsh
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

function backup_item() 
{
  # colored msgs for debug
  local OK="[ \033[1;32mOK\033[0m ]"
  local FAILED="[ \033[1;31mFailed\033[0m ]"

  local src=$1

  rm -rf "$BACKUP_DIR/$src"
  cp -r "$src" "$BACKUP_DIR/"

  # extract just the filename or directory name from path
  local src_filtered="${src##*/}"

  if [[ $? -eq 0 ]]; then
    printf "$OK Copied $src_filtered file successfully into $BACKUP_DIR/\n" \
    || printf "$FAILED Could not copy $src_filtered file into $BACKUP_DIR/\n"  
  fi
}

# backup configs in .config/ directories
for dot in "${CONFIG_DIRS[@]}"; do
  backup_item "$HOME/.config/$dot"
done

# backup configs in home/ dir
for dot in "${HOME_DIRS[@]}"; do 
  backup_item "$HOME/$dot"
done
