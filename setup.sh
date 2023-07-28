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
    git \
    curl \
    zsh \

# Install Rust
echo Installing Rust...
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo Installing Rustup components...
rustup toolchain install nightly

# Cargo installs
echo Installing dev tools from cargo...
apps=(loki-cli nu bat ripgrep fd-find git-delta xh hyperfine hexyl pastel)
for app in "${apps[@]}"; do
    cargo install $app --locked
done

cargo +nightly install dua-cli --locked
