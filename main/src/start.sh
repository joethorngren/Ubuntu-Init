#!/bin/bash

echo "***********"
echo "Updating..."
echo "***********"
sudo apt-get update -y

echo "***********"
echo "Upgrading..."
echo "***********"
sudo apt-get upgrade -y

# Add Git Repository + Install Git

sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update -y
sudo apt-get install git

# Vim

sudo apt-get install vim

# Z-Shell

sudo apt-get install git-core zsh zsh-completions
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo apt-get install fonts-powerline

# i3

/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3 -y

# IntelliJ

wget -O ~/Downloads/ideaIU-2017.1.2.tar.gz https://download.jetbrains.com/idea/ideaIU-2017.1.2.tar.gz

# Android SDK

wget -O ~/Downloads/tools_r25.2.3-linux.zip https://dl.google.com/android/repository/tools_r25.2.3-linux.zip

# Install Slack

wget -O ~/Downloads/slack-desktop-2.6.0-amd64.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.0-amd64.deb
sudo dpkg -i ~/Downloads/slack-desktop-2.6.0-amd64.deb

# Install Calibre

wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda x,y:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('~/calibre-bin', True)"

# Configure Git

git config --global user.name "Joe Thorngren"
git config --global user.email "joethorngren@gmail.com"
