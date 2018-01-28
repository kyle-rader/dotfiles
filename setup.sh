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


header "Install Google Chrome"
CHROME="google-chrome-stable_current_amd64.deb"
wget "https://dl.google.com/linux/direct/$CHROME"
sudo apt install -y ./$CHROME
rm $CHROME

header "Install Slack"
SLACK="slack-desktop-3.0.5-amd64.deb"
wget https://downloads.slack-edge.com/linux_releases/$SLACK
sudo apt install -y ./$SLACK
rm $SLACK

header "Install Spotify"
#(Following: https://www.spotify.com/us/download/linux/)
# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
# 3. Update# Exist if any command returns with non-zero exit status fail.
set -e

function header() {
  printf "\n======================================================================\n"
  printf "$1"
  printf "\n======================================================================\n"
} list of available packages
sudo apt-get update
# 4. Install Spotify
sudo apt-get install -y spotify-client


header "Install Docker"
#(Following: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl status docker
# Add our user to the docker group
sudo usermod -aG docker ${USER}
su - ${USER}
echo $USER groups
id -nG

header "Install Visual Studio Code"
CODE="code_1.19.3-1516876437_amd64.deb"
wget https://az764295.vo.msecnd.net/stable/7c4205b5c6e52a53b81c69d2b2dc8a627abaa0ba/$CODE
sudo apt install ./$CODE
rm $CODE

header "Install Anaconda"
ANACONDA="Anaconda3-5.0.1-Linux-x86_64.sh"
curl https://repo.continuum.io/archive/$ANACONDA
./$ANACONDA
rm $ANACONDA

header "Install Oh-My-ZSH"
wget -qO- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

header "Install nvm"
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

header "Install rbenv"
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
~/.rbenv/bin/rbenv init

mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
cd -
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

header "Copy dotfiles"
cp .zshrc ~/.zshrc
cp .custom-zsh ~/.custom-zsh
cp .gitconfig ~/.gitconfig

header "Log out and Log back in - then run setup2.sh"
