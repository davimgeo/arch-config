#!/bin/zsh

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

mkdir -p dots

# I3
rm -fr dots/i3 && cp -r ~/.config/i3 dots/ && \
  printf "$OK Copied I3 files successfully into dots/\n" || \
  printf "$FAILED Could not copy I3 files into dots/\n"

# nvim
rm -fr dots/nvim && cp -r ~/.config/nvim dots/ && \
  printf "$OK Copied nvim files successfully into dots/\n" || \
  printf "$FAILED Could not copy nvim files into dots/\n"

# Alacritty
rm -fr dots/alacritty && cp -r ~/.config/alacritty dots/ && \
  printf "$OK Copied alacritty files successfully into dots/\n" || \
  printf "$FAILED Could not copy alacritty files into dots/\n"

# .zshrc
rm -f dots/.zshrc && cp ~/.zshrc dots/ && \
  printf "$OK Copied zshrc file successfully into dots/\n" || \
  printf "$FAILED Could not copy zshrc file into dots/\n"

# .xinitrc
rm -f dots/.xinitrc && cp ~/.xinitrc dots/ && \
  printf "$OK Copied xinitrc file successfully into dots/\n" || \
  printf "$FAILED Could not copy xinitrc file into dots/\n"

# .zprofile
rm -f dots/.zprofile && cp ~/.zprofile dots/ && \
  printf "$OK Copied zprofile file successfully into dots/\n" || \
  printf "$FAILED Could not copy zprofile file into dots/\n"

