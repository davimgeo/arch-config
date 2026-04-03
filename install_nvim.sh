#!/bin/bash

OK="[ \033[1;32mOK\033[0m ]"
FAILED="[ \033[1;31mFailed\033[0m ]"

function install_nvim()
{
    confirm_install=""
    confirm_skip=""

    echo -n "Do you already have nvim 0.12.0 installed? (Y/N): "
    read confirm_install

    if [[ $confirm_install == [nN] || $confirm_install == [nN][oO] ]]; then
        echo "Continuing..."
    else
        echo "Skipping Neovim install..."
        return
    fi

    echo -n "Skip cloning nvim? (Y/N): "
    read confirm_skip

    if [[ $confirm_skip == [nN] || $confirm_skip == [nN][oO] ]]; then
        echo "Continuing..."

        git clone https://github.com/neovim/neovim.git ~/neovim || { printf "$FAILED Clone failed\n"; exit 1; }
        printf "$OK Downloaded nvim successfully\n"
    fi

    echo "Procceding to install nvim..."

    make -C ~/neovim CMAKE_BUILD_TYPE=RelWithDebInfo || { printf "$FAILED Build failed\n"; exit 1; }
    sudo make -C ~/neovim install || { printf "$FAILED Install failed\n"; exit 1; }

    printf "$OK Installed nvim successfully\n"

    echo "Removing neovim folders..."

    rm -fr ~/neovim || { printf "$FAILED Removing neovim folders failed\n"; exit 1; }

    printf "$OK Removed neovim folders successfully\n"

    printf "$OK Instalation completed\n"
}

function install_nvim_config()
{
    echo "Copying nvim config..."
    cp -r dots/nvim ~/.config || { printf "$FAILED Coping nvim config into .config failed\n"; exit 1; }

    echo "Installing Packer..."

    PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

    if [ -d "$PACKER_DIR" ]; then
      echo "Packer already exists, overwriting..."
      rm -rf "$PACKER_DIR"
    fi

    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR" \
      || { printf "$FAILED Packer installation failed\n"; exit 1; }

}

install_nvim
install_nvim_config
