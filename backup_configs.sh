#!/bin/zsh

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

mkdir -p dots

# DWM
rm -fr dots/dwm && cp -r ~/.config/dwm dots/ && \
  rm -rf dots/dwm/.git && \
  printf "$OK Copied dwm files successfully into dots/\n" || \
  printf "$FAILED Could not copy dwm files into dots/\n"

# Alacritty
rm -fr dots/alacritty && cp -r ~/.config/alacritty dots/ && \
  rm -rf dots/alacritty/.git && \
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

