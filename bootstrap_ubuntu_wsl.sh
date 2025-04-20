#!/bin/bash

set -e

sudo apt-get update -y && sudo NEEDRESTART_MODE=a apt-get upgrade -y && sudo apt autoremove -y

# Add repositories for python3.12
sudo add-apt-repository ppa:deadsnakes/ppa -y

# Add repositories for WSLUtilities
sudo add-apt-repository ppa:wslutilities/wslu -y

# Add repositories for Git
sudo add-apt-repository ppa:git-core/ppa

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
    docker-buildx-plugin docker-compose-plugin net-tools stow tree \
    unzip wslu python3-pip vault

# Add your user to the docker group so that you can run docker without sudo
sudo usermod -aG docker "$USER" && sudo systemctl enable docker && sudo systemctl start docker

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && sudo /tmp/aws/install

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# aactivator.py script
AACTIVATOR_URL="https://raw.githubusercontent.com/Yelp/aactivator/master/aactivator.py"

INSTALL_DIR="$HOME/.local/bin"
[[ ! -d $INSTALL_DIR ]] && mkdir -p "$INSTALL_DIR"
PATH="${PATH:+${PATH}:}${INSTALL_DIR}"

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
    git clone -b "introduce_dotfiles" https://github.com/vigneshsubbaram/dotfiles.git "$DOTFILES_PATH"
else
    git -C "$DOTFILES_PATH" pull --ff
fi
pushd "$DOTFILES_PATH"

[[ ! -d $HOME/.config ]] && mkdir -p "$HOME"/.config
cp .zshenv ~/

stow -t "$HOME/.config" .config

ln -sf "$HOME/.config/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/.config/git/.gitignore" "$HOME/.gitignore"
ln -sf "$HOME/.config/dotbins/.dotbins.yaml" "$HOME/.dotbins.yaml"
ln -sf "$HOME/.config/bash/.bashrc" "$HOME/.bashrc"

# Install commitizen
pip install --user -U commitizen dotbins

# Install binaries via dotbins
dotbins get --dest ~/.local/bin ~/.config/dotbins/dotbins.yaml

# Install zap plugin manager
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep

stow -t "$HOME/.config" .config

# Setup auto-completion for kubectx and kubens
mkdir -p ~/.config/zsh/completions
curl -sSL https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh -o ~/.config/zsh/completions/_kubectx
curl -sSL https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh -o ~/.config/zsh/completions/_kubens

popd
