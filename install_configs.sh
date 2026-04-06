#!/bin/bash

dependencies=(
  zoxide fzf curl 
  unzip tar cmake ripgrep
  npm build-essential pkg-config libtool 
  libtool-bin autoconf automake g++ clangd
)

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

function error() {
  local text="$1"
  printf "%b %s\n" "$FAILED" "$text"
  exit 1
}

function install_dependencies() {
  local confirm_download

  echo -n "Do you want to download the dependencies? (Y/N): "
  read confirm_download

  if [[ ! "$confirm_download" =~ ^([yY]|[yY][eE][sS])$ ]]; then
    echo "Skipping dependencies installation."
    return
  fi

  local missing=()

  for lib in "${dependencies[@]}"; do
    if ! command -v "$lib" >/dev/null 2>&1; then
      missing+=("$lib")
    fi
  done

  if [[ ${#missing[@]} -eq 0 ]]; then
    printf "%b All dependencies already installed.\n" "$OK"
    return
  fi

  echo "Installing: ${missing[*]}"
  sudo apt update
  sudo apt install -y "${missing[@]}" || error "Could not install dependencies"

  printf "%b Dependencies installed successfully.\n" "$OK"

function install_nvim() {

  local confirm_install=""
  local confirm_skip=""

  echo -n "Do you already have nvim 0.12.0 installed? (Y/N): "
  read confirm_install

  if [[ $confirm_install != [nN] && $confirm_install != [nN][oO] ]]; then
    echo "Skipping Neovim install..."
    return
  fi

  echo -n "Skip cloning nvim? (Y/N): "
  read confirm_skip

  if [[ $confirm_skip == [nN] || $confirm_skip == [nN][oO] ]]; then
    echo "Cloning Neovim..."
    git clone https://github.com/neovim/neovim.git $HOME/neovim || error "Clone failed"
    printf "%b Downloaded nvim successfully\n" "$OK"
  fi

  echo "Proceeding to install Neovim..."

  make -C ~/neovim CMAKE_BUILD_TYPE=RelWithDebInfo || error "Build failed"
  sudo make -C ~/neovim install || error "Install failed"
  printf "%b Installed nvim successfully\n" "$OK"

  echo "Removing Neovim source folder..."
  rm -fr ~/neovim || error "Removing Neovim folder failed"
  printf "%b Removed Neovim folder successfully\n" "$OK"

  echo "Copying Neovim config into ~/.config..."
  cp -r dots/nvim ~/.config || error "Copying Neovim config failed"
  printf "%b Copied Neovim config successfully\n" "$OK"

  echo "Installing Packer..."
  PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

  if [ -d "$PACKER_DIR" ]; then
    echo "Packer already exists, removing old version..."
    rm -rf "$PACKER_DIR"
  fi

  git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR" \
    || error "Packer installation failed"

  echo "Running PackerSync..."
  nvim --headless +PackerSync +qa || error "PackerSync failed"
  printf "%b PackerSync completed successfully\n" "$OK"

  printf "%b Neovim installation completed\n" "$OK"
}

function install_zsh() {
  confirm_download=""
  confirm_install=""

  if ! command -v zsh >/dev/null 2>&1; then
    echo -n "Do you want to download zsh? (Y/N): "
    read confirm_download

    if [[ $confirm_download != [yY] && $confirm_download != [yY][eE][sS] ]]; then
      echo "Skipping zsh installation."
      return
    fi

    echo "Dowloading zsh..."
    sudo apt install zsh -y || error "Could not install zsh"
    printf "%b Installed zsh successfully\n" "$OK"
  fi

  confirm_install=""

  echo -n "Do you want to install zsh? (Y/N): "
  read confirm_install

  if [[ $confirm_install != [yY] && $confirm_install != [yY][eE][sS] ]]; then
    echo "Skipping zsh instalation..."
    return
  fi

  echo "Moving .zshrc into $HOME..."
  cp dots/.zshrc ~ || error "Could not move .zshrc to ~"

  echo "Changing shell..."
  sudo chsh -s /usr/bin/zsh $USER || error "Could not change shell to zsh"
  zsh || error "Could not execute zsh"
}

install_dependencies
install_nvim
install_zsh
