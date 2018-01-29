#!/bin/bash

# Exist if any command returns with non-zero exit status fail.
set -e

function header() {
  printf "\n======================================================================\n"
  printf "$1"
  printf "\n======================================================================\n"
}

# isCommand(command):
#   returns 0 if command is not in path, 1 otherwise.
#   Does not recongnize bash aliases
function isCommand() {
  echo "Checking for \"$1\"..."
  hash "$1" 2>/dev/null || command -v "$1"
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
  zlib1g-dev \
  libncurses5-dev \
  libgdbm3 \
  libgdbm-dev \
  libssl-dev \
  libffi-dev \
  git \
  git-extras \
  curl \
  htop \
  unzip \
  vim \
  zsh \
  python-dev \
  openssl \
  dnsmasq \
  openjdk-8-jdk \
  openjdk-8-jre \
  python3-pip python3-venv python3-venv \
  fonts-powerline

if [ "$SHELL" == "/bin/bash" ]; then
  header "Change Shell"
  chsh -s "$(which zsh)"
fi

exec zsh setup2.sh
