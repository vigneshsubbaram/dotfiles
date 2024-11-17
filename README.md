# My dotfiles

Welcome to my dotfiles collection! This repository contains all the core configuration files I rely on for Python development and everyday computing. These dotfiles ensure I can maintain the same streamlined and productive workflow no matter which system I'm using.

## WSL Distro Install and Setup Instructions

- Download your desired Ubuntu distro from - [Ubuntu Cloud Images](https://cloud-images.ubuntu.com/wsl/releases/)

- Import the distro using:

```bash
wsl.exe --import <Distribution Name> <Install Folder> <.TAR.GZ File Path>
```

- Add a  non-root user via the `adduser` command:

```bash
PS C:\Users\Username> wsl -d DistroA
root@DESKTOP:/mnt/c/Users/Username# NEW_USER=username
root@DESKTOP:/mnt/c/Users/Username# adduser "${NEW_USER}"
Adding user `username' ...
Adding new group `username' (1000) ...
Adding new user `username' (1000) with group `username' ...
Creating home directory `/home/username' ...
Copying files from `/etc/skel' ...
New password: ****
Retype new password: ****
passwd: password updated successfully
Changing the user information for username
Enter the new value, or press ENTER for the default
        Full Name []: User Name
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n]
```

- Enable sudoer privileges for ${NEW_USER}:

```bash
adduser ${NEW_USER} sudo
```

- Set the default user in /etc/wsl.conf:

```bash
tee /etc/wsl.conf <<_EOF
[user]
default=${NEW_USER}

[boot]
systemd=true
_EOF
```

- Terminate your WSL distro for your changes to take effect

```bash
wsl --terminate DistroA
```

## Installation

Run the bootstrap script to setup the dotfiles

```bash
wget -q https://raw.githubusercontent.com/vigneshsubbaram/dotfiles/refs/heads/main/bootstrap_ubuntu_wsl.sh -O - | bash
```
