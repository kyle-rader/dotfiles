#!/usr/bin/env bash

set -e

echo Starting setup...

# Update and Upgrade
echo Updating and Upgrading...
sudo apt-get update
sudo apt-get upgrade -y

# Install essentials
echo Installing essentials...
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
    zsh \

# Install latest git
echo Installing git...
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git

# Install Rust
echo Installing Rust...
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo Installing Rustup components...
rustup toolchain install nightly

# Cargo installs
echo Installing dev tools from cargo...
apps=(loki-cli nu bat ripgrep fd-find git-delta xh hyperfine hexyl pastel)
for app in "${apps[@]}"; do
    cargo install $app --locked
done

cargo +nightly install dua-cli --locked

# Copy dotfiles
echo Copying dotfiles...
curl -L -o ~/.gitconfig https://raw.githubusercontent.com/kyle-rader/dotfiles/main/.gitconfig