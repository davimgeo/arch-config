# default editor
export EDITOR=nvim

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

alias xsc="xclip -selection clipboard"

# Basic Bash aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt template

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

chpwd() {
  ls --color=auto
}

bindkey -s '^[c' 'git commit -m ""\C-b'
bindkey -s '^[p' 'git push origin '

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

