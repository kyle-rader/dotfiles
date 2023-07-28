#!/usr/bin/env bash

function header() {
  printf "\n======================================================================\n"
  printf "$1"
  printf "\n======================================================================\n"
}

set -e

header "Starting setup"

# Update and Upgrade
header "Updating and Upgrading"
sudo apt-get update > /dev/null
sudo apt-get upgrade -y > /dev/null

# Install essentials
header "Installing essentials"
sudo apt-get install -y \
    build-essential \
    pkg-config \
    libssl-dev \
    libyaml-dev \
    unzip \
    vim \
    openssl \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl \
    zsh > /dev/null

# Install latest git
header "Installing git"
sudo add-apt-repository ppa:git-core/ppa > /dev/null
sudo apt update > /dev/null
sudo apt install git > /dev/null

# Install Rust
header "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q
source "$HOME/.cargo/env"

header "Installing Rust Nightly Toolchain"
rustup toolchain install nightly > /dev/null

# Cargo installs
header "Installing dev tools from cargo"
apps=(loki-cli nu bat ripgrep fd-find git-delta xh hyperfine hexyl pastel)
for app in "${apps[@]}"; do
    echo -n intalling $app
    cargo install $app --locked > /dev/null
    echo ✅
done

cargo +nightly install dua-cli --locked > /dev/null

# Copy dotfiles
header "Copying dotfiles"
curl -L -o ~/.gitconfig https://raw.githubusercontent.com/kyle-rader/dotfiles/main/.gitconfig