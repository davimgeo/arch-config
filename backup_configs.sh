#!/bin/zsh

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

rm -fr dotfiles/dwm || cp -r ~/.config/dwm dotfiles/ && printf "$OK Copied dwm files successfully into dotfiles/\n" || \
	printf "$FAILED Could not copy dwm files into dotfiles/\n"

rm -fr dotfiles/alacritty ||cp -r ~/.config/alacritty dotfiles/ && printf "$OK Copied alacritty files successfully into dotfiles/\n" || \
	printf "$FAILED Could not copy alacritty files into dotfiles/\n"

