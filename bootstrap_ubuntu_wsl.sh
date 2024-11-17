#!/bin/bash

set -e

sudo apt-get update -y && sudo NEEDRESTART_MODE=a apt-get upgrade -y && sudo apt autoremove -y

# Add repositories for python3.12
sudo add-apt-repository ppa:deadsnakes/ppa -y

# Add repositories for WSLUtilities
sudo add-apt-repository ppa:wslutilities/wslu -y

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

# Add sources for vault
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update

# Install packages
sudo NEEDRESTART_MODE=a apt install -y python3.12-full python-is-python3 gcc zsh make git \
    apt-transport-https docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin net-tools stow \
    unzip wslu python3-pip vault

# Add your user to the docker group so that you can run docker without sudo
sudo usermod -aG docker "$USER" && sudo systemctl start docker

# Install commitizen
pip install --user -U commitizen

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && sudo /tmp/aws/install

# Install kubectl
curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /tmp/kubectl && \
    sudo install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl

# Install kubectx and kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# Install bosh CLI
curl -sL https://api.github.com/repos/cloudfoundry/bosh-cli/releases/latest | grep "browser_download_url.*linux-amd64" \
    | cut -d : -f 2,3 | tr -d \" | sudo wget -O /usr/local/bin/bosh -qi - && sudo chmod a+x /usr/local/bin/bosh

# Install CF CLI
curl -L https://github.com/cloudfoundry/cli/releases/download/v6.53.0/cf-cli_6.53.0_linux_x86-64.tgz | tar xz -C /tmp && \
    sudo mv /tmp/cf /usr/local/bin

# Install k9s
curl -L -o /tmp/k9s.deb https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb && \
    sudo dpkg -i  /tmp/k9s.deb

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

# Setup auto-completion for kubectx and kubens
mkdir -p ~/.config/zsh/completions
sudo ln -s /opt/kubectx/completion/_kubectx.zsh ~/.config/zsh/completions/_kubectx
sudo ln -s /opt/kubectx/completion/_kubens.zsh ~/.config/zsh/completions/_kubens

# Windows terminal
windowsUsername=$(powershell.exe '$env:UserName' | tr -d '\r')
terminalDir=/home/vignesh/../../mnt/c/Users/$windowsUsername/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState
downloadsDir=/home/vignesh/../../mnt/c/Users/$windowsUsername/Downloads

if [ ! -e "$terminalDir/settings.json" ]; then
    cp ./windows-terminal-settings.json "$terminalDir/LocalState/settings.json"
    cp ./icons/ubuntu.png "$downloadsDir"
fi

popd
