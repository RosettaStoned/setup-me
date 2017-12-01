#!/bin/bash

set -e

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

exists() {
    command -v "$1" >/dev/null 2>&1
}


function check_zsh() {
  if exists "zsh"; then
    error "You must have 'zsh' installed to continue"
  fi
}

function check_curl() {
  if exists "curl"; then
    error "You must have 'curl' installed to continue"
  fi
}

function install_oh_my_zsh() {
  msg "Installing oh-my-zsh."

  check_zsh
  check_curl

  msg "Fetching oh-my-zsh install script."
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
  success "Install script for oh-my-zsh is fetched and installed successfully."
  cp .zshrc ~/.zshrc

  chsh -s $(which zsh)
  su - $USER

  success "oh-my-zsh is installed successfully."
}

function install_space_vim() {
  msg "Installing space-vim."

  check_curl

  msg "Fetching space-vim install script."
  curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh
  success "Install script for space-vim is fetched and installed successfully."
  cp .spacevim ~/.spacevim
}

function install() {
  sudo apt-get install -y zsh \
  vim \
  neovim \
  curl

  install_oh_my_zsh
  install_space_vim
}

install
