#!/usr/bin/env bash

function header() {
  echo
  echo "==== ⚒️ ===="
  echo "$1"
}

function footer_good() {
    echo
    echo "==== ✅ ===="
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
    libncurses5-dev \
    libncursesw5-dev \
    zsh > /dev/null

footer_good

# Install latest git
if [ -z "$(command -v git)" ]; then
    header "Installing git"
    sudo add-apt-repository ppa:git-core/ppa > /dev/null
    sudo apt update > /dev/null
    sudo apt install git > /dev/null
else
    header "Git already installed"
fi

footer_good

# Install Rust
if [ -z "$(command -v cargo)" ]; then
    header "Installing Rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q
    # Enable cargo in the current shell
    source "$HOME/.cargo/env"
    footer_good

    header "Installing Rust Nightly Toolchain"
    rustup toolchain install nightly > /dev/null
else
    header "Rust already installed"
fi

footer_good

# Cargo installs
header "Installing dev tools from cargo"
cargo install -q cargo-binstall > /dev/null
apps=(loki-cli nu bat ripgrep fd-find git-delta xh hyperfine hexyl pastel rtx-cli nu)
for app in "${apps[@]}"; do
    echo intalling $app
    cargo binstall -q $app -y
    if [ "$?" == "0" ]; then
        echo ✅
    else
        echo ❌
    fi
done
footer_good

# RTX Installs
eval "$(rtx activate bash)"
header "Installing Node"
rtx install node@latest
rtx use -g node@latest
footer_good

header "Installing Elixir/OTP"
rtx use -g erlang@25
rtx use -g elixir@1.14.5-otp-25
footer_good

# Copy dotfiles
header "Copying dotfiles"
curl -L -o ~/.gitconfig https://raw.githubusercontent.com/kyle-rader/dotfiles/main/.gitconfig
curl -L -o ~/.zshrc https://raw.githubusercontent.com/kyle-rader/dotfiles/main/.zshrc
footer_good

# Change default shell to ZSH
if [ "$SHELL" != "/bin/zsh" ]; then
    header "Changing shell to ZSH"
    sudo chsh -s /bin/zsh
    header "🎉 launching zsh"
    exec -l zsh
else
    header "🎉 all done 🎉"
    footer_good
fi