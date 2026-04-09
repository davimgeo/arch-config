# ================================
# Instant Prompt (must be at top)
# ================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ================================
# Environment & Defaults
# ================================
export EDITOR=nvim

# ================================
# Exit if not interactive
# ================================
[[ $- != *i* ]] && return

# ================================
# History Configuration
# ================================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# ================================
# Zinit (Plugin Manager)
# ================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ================================
# Plugins
# ================================
# Powerlevel10k theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Core plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# OMZ snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# ================================
# Completion System
# ================================
autoload -Uz compinit
zmodload zsh/complist
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# fzf-tab previews
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Replay completions
zinit cdreplay -q

# ================================
# Keybindings
# ================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Edit command in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Git shortcuts
bindkey -s '^[a' 'git add .'
bindkey -s '^[ck' 'git commit -m ""\C-b'
bindkey -s '^[p' 'git push origin '

# ================================
# Aliases
# ================================
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias c='clear'
alias xsc="xclip -selection clipboard"

# Zsh config
alias czsh="sudo nvim ~/.zshrc"
alias uzsh="source ~/.zshrc"

# Neovim
alias cnvim="nvim ~/.config/nvim/"

# Alacritty
alias cala="sudo nvim ~/.config/alacritty/alacritty.toml"

# DWM
alias fdwm="cd ~/.config/dwm"
alias cdwm="sudo nvim ~/.config/dwm/config.h"
alias udwm='printf "Updating dwm file...\n"; cd ~/.config/dwm/ && sudo make clean install'

# i3
alias fi3="cd ~/.config/i3"
alias ci3="sudo nvim ~/.config/i3/config"

# ================================
# Shell Integrations
# ================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"
# ================================
# Functions
# ================================
chpwd() {
  ls --color=auto
}

# ================================
# Prompt
# ================================
# Load Powerlevel10k config if present
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
