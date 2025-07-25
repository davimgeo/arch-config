#!/bin/zsh

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

rm -fr dotfiles/dwm || cp -r ~/.config/dwm dotfiles/ && printf "$OK Copied dwm files successfully into dotfiles/\n" || \
	printf "$FAILED Could not copy dwm files into dotfiles/\n"

rm -fr dotfiles/alacritty || cp -r ~/.config/alacritty dotfiles/ && printf "$OK Copied alacritty files successfully into dotfiles/\n" || \
	printf "$FAILED Could not copy alacritty files into dotfiles/\n"

rm -fr dotfiles/.zshrc || cp ~/.zshrc dotfiles/ && printf "$OK Copied zshrc file sucessfully into dotfiles/\n" || \
	printf "$FAILED Could not copy zshrc file into dotfiles/\n"

rm -fr dotfiles/.xinitrc || cp ~/.xinitrc dotfiles/ && printf "$OK Copied xinirc file sucessfully into dotfiles/\n" || \
	printf "$FAILED Could not copy xinitrc file into dotfiles/\n"

rm -fr dotfiles/.zprofile || cp ~/.zprofile dotfiles/ && printf "$OK Copied zprofile file sucessfully into dotfiles/\n" || \
	printf "$FAILED Could not copy zprofile file into dotfiles/\n"


