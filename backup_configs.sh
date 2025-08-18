#!/bin/zsh
# *****************
# Backup dotfiles
# *****************

# array of configs in .config dir 
CONFIG_DIRS=(
  i3      nvim     alacritty
)

# array of configs in home dir
HOME_DIRS = (
  .zshrc .zprofile .xinitrc
)

BACKUP_DIR="dots"

function backup_item() {
  # colored msgs for debug
  local OK="[ \033[1;32mOK\033[0m ]"
  local FAILED="[ \033[1;31mFailed\033[0m ]"

  local src=$1

  rm -rf "$BACKUP_DIR/$src"
  cp -r "$src" "$BACKUP_DIR/"

  if [[ $? -eq 0 ]]; then
    printf "$OK Copied $src files successfully into $BACKUP_DIR/\n" \
    || printf "$FAILED Could not copy $src files into $BACKUP_DIR/\n"  
  fi
}

# backup configs in .config/ directories
for dot in "${config_dirs[@]}"; do
  backup_item "$HOME/.config/$dot"
done

# backup configs in home/ dir
for dot in "${HOME_DIRS[@]}"; do 
  backup_item "$HOME/$dot"
done
