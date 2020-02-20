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
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Skipping Oh-My-ZSH"
fi

if ! isCommand "google-chrome" ; then
  header "Install Google Chrome"
  CHROME="google-chrome-stable_current_amd64.deb"
  wget "https://dl.google.com/linux/direct/$CHROME"
  sudo apt install -y ./$CHROME
  rm $CHROME
else
  echo "Skipping Google Chrome"
fi

if ! isCommand "spotify" ; then
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install spotify-client
else
  echo "Skipping Spotify"
fi

if ! isCommand "code" ; then
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt-get update
  sudo apt-get install code
else
  echo "Skipping VS Code"
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
else
  echo "Skipping Ruby Env (rbenv)"
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
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m`" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
else
  echo "Skipping docker"
fi

header "Copy dotfiles"
cp .zshrc ~/.zshrc
cp .custom-zsh.sh ~/.custom-zshrc.sh
cp .gitconfig ~/.gitconfig

header "Log out and Log back in - then run setup3.sh"
