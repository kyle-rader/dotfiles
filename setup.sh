#!/bin/bash

# Exist if any command returns with non-zero exit status fail.
set -e

function header() {
  printf "\n======================================================================\n"
  printf "$1"
  printf "\n======================================================================\n"
}

header "Update and Upgrade the system"
sudo apt update
sudo apt upgrade -y

header "Install dev dependencies"
sudo apt install -y \
  build-essential \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  autoconf \
  bison \
  libyaml-dev \
  libreadline6-dev \
  git \
  curl \
  htop \
  unzip \
  vim \
  zsh \
  python-dev \
  openssl \
  dnsmasq \
  fonts-powerline

if [ "$SHELL" == "/bin/bash" ]; then
  header "Change Shell"
  chsh -s "$(which zsh)"
fi

cp .gitconfig ~/.gitconfig

exec zsh setup2.sh
