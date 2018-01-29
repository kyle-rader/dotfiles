#!/bin/zsh

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

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  header "Install Oh-My-ZSH"
  sudo chsh -s $(which zsh)
  wget -qO- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
fi

if ! isCommand "google-chrome" ; then
  header "Install Google Chrome"
  CHROME="google-chrome-stable_current_amd64.deb"
  wget "https://dl.google.com/linux/direct/$CHROME"
  sudo apt install -y ./$CHROME
  rm $CHROME
fi

if ! isCommand "slack" ; then
  header "Install Slack"
  SLACK="slack-desktop-3.0.5-amd64.deb"
  wget https://downloads.slack-edge.com/linux_releases/$SLACK
  sudo apt install -y ./$SLACK
  rm $SLACK
fi

if ! isCommand "spotify" ; then
  header "Install Spotify"
  #(Following: https://www.spotify.com/us/download/linux/)
  # 1. Add the Spotify repository signing keys to be able to verify downloaded packages
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
  # 2. Add the Spotify repository
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  # 3. Update# Exist if any command returns with non-zero exit status fail.
  sudo apt-get update
  # 4. Install Spotify
  sudo apt-get install -y spotify-client
fi

if ! isCommand "code" ; then
  header "Install Visual Studio Code"
  CODE="code_1.19.3-1516876437_amd64.deb"
  wget https://az764295.vo.msecnd.net/stable/7c4205b5c6e52a53b81c69d2b2dc8a627abaa0ba/$CODE
  sudo apt install ./$CODE
  rm $CODE
fi

if ! isCommand "nvm" ; then
  header "Install nvm"
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
fi

if [ ! -d "$HOME/.rbenv" ]; then
  header "Install rbenv"
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  pushd ~/.rbenv && src/configure && make -C src && popd

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
fi

if ! isCommand "meteor" ; then
  header "Install Meteor"
  curl https://install.meteor.com/ | sh
fi

if ! isCommand "tilix" ; then
  header "Install Tilix"
  wget https://github.com/gnunn1/tilix/releases/download/1.7.5/tilix.zip
  sudo unzip tilix.zip -d /
  sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
  sudo update-alternatives --config x-terminal-emulator
fi

if ! isCommand "docker" ; then
  header "Install Docker"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial Release stable"
  sudo apt-get update
  # apt-cache policy docker-ce
  sudo apt-get install -y docker-ce
  # sudo systemctl status docker
  # Add our user to the docker group
  sudo usermod -aG docker ${USER}

  # Docker COmpose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m`" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version

fi

header "Copy dotfiles"
cp .zshrc ~/.zshrc
cp .custom-zsh.sh ~/.custom-zshrc.sh
cp .gitconfig ~/.gitconfig

header "Log out and Log back in - then run setup3.sh"
