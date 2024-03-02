#!/bin/bash

set -e

sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt autoremove -y

# Add repositories for python3.12
sudo add-apt-repository ppa:deadsnakes/ppa -y

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get update

# Install packages
sudo apt install -y python3.12-full python-is-python3 gcc zsh make git \
    apt-transport-https docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin net-tools stow

# Add your user to the docker group so that you can run docker without sudo
sudo usermod -aG docker "$USER"

# aactivator.py script
AACTIVATOR_URL="https://raw.githubusercontent.com/Yelp/aactivator/master/aactivator.py"

INSTALL_DIR="$HOME/.local/bin"
[[ ! -d $INSTALL_DIR ]] && mkdir -p "$INSTALL_DIR"
path+=${INSTALL_DIR}

# Download the aactivator.py script
curl -o "${INSTALL_DIR}/aactivator" "${AACTIVATOR_URL}"

# Make the aactivator script executable
chmod +x "${INSTALL_DIR}/aactivator"

# Change default shell to zsh
sudo usermod -s /usr/bin/zsh "$USER"

# Create a workspace directory
USER_WORKSPACE=$HOME/workspace/$USER
[[ ! -d $USER_WORKSPACE ]] && mkdir -p "$USER_WORKSPACE"

# Download and setup config files
DOTFILES_PATH=$USER_WORKSPACE/dotfiles
if [[ ! -d $DOTFILES_PATH ]]; then
    git clone https://github.com/vigneshsubbaram/dotfiles.git "$DOTFILES_PATH"
else
    git -C "$DOTFILES_PATH" pull --ff
fi
pushd "$DOTFILES_PATH"

[[ ! -d $HOME/.config ]] && mkdir -p "$HOME"/.config
cp .zshenv ~/
cp .gitconfig ~/

stow -t "$HOME/.config" .config

# Install zap plugin manager
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep

stow -t "$HOME/.config" .config

# Windows terminal
windowsUsername=$(powershell.exe '$env:UserName' | tr -d '\r')
terminalDir=/home/vignesh/../../mnt/c/Users/$windowsUsername/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState
downloadsDir=/home/vignesh/../../mnt/c/Users/$windowsUsername/Downloads

if [ ! -e "$terminalDir/settings.json" ]; then
    cp ./windows-terminal-settings.json "$terminalDir/LocalState/settings.json"
    cp ./icons/ubuntu.png "$downloadsDir"
fi

popd
