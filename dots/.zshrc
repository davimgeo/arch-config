# default editor
export EDITOR=nvim

alias xsc="xclip -selection clipboard"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Basic Bash aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt template
BOLDGREEN=$(tput bold setaf 2)
BOLDBLUE=$(tput bold setaf 4)
RESET=$(tput sgr0)

PROMPT="%{$BOLDBLUE%}%~%{$RESET%} %{$BOLDGREEN%}>%{$RESET%} "

# .zshrc configs
alias czsh="sudo nvim ~/.zshrc"
alias uzsh="source ~/.zshrc"

# nvim configs
alias cnvim="nvim ~/.config/nvim/"

# Alacritty configs
alias cala="sudo nvim ~/.config/alacritty/alacritty.toml"

# Dwm configs
alias fdwm="cd ~/.config/dwm"
alias cdwm="sudo nvim ~/.config/dwm/config.h"
alias udwm='printf "Updating dwm file...\n"; cd ~/.config/dwm/ && sudo make clean install'

# i3 configs
alias fi3="cd ~/.config/i3"
alias ci3="sudo nvim ~/.config/i3/config"

