#!/bin/zsh

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

# DWM
rm -fr dotfiles/dwm && cp -r ~/.config/dwm dotfiles/ && \
  printf "$OK Copied dwm files successfully into dotfiles/\n" || \
  printf "$FAILED Could not copy dwm files into dotfiles/\n"

# Alacritty
rm -fr dotfiles/alacritty && cp -r ~/.config/alacritty dotfiles/ && \
  printf "$OK Copied alacritty files successfully into dotfiles/\n" || \
  printf "$FAILED Could not copy alacritty files into dotfiles/\n"

# .zshrc
rm -f dotfiles/.zshrc && cp ~/.zshrc dotfiles/ && \
  printf "$OK Copied zshrc file successfully into dotfiles/\n" || \
  printf "$FAILED Could not copy zshrc file into dotfiles/\n"

# .xinitrc
rm -f dotfiles/.xinitrc && cp ~/.xinitrc dotfiles/ && \
  printf "$OK Copied xinitrc file successfully into dotfiles/\n" || \
  printf "$FAILED Could not copy xinitrc file into dotfiles/\n"

# .zprofile
rm -f dotfiles/.zprofile && cp ~/.zprofile dotfiles/ && \
  printf "$OK Copied zprofile file successfully into dotfiles/\n" || \
  printf "$FAILED Could not copy zprofile file into dotfiles/\n"

