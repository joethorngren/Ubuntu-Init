#!/bin/bash

echo ""
echo ""
echo "***********"
echo "Updating..."
echo "***********"
echo ""
echo ""

sudo apt-get update -y

echo ""
echo ""
echo "Done updating!"
echo ""
echo ""

echo ""
echo ""
echo "***********"
echo "Upgrading..."
echo "***********"
echo ""
echo ""

sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

echo ""
echo ""
echo "Done upgrading!"
echo ""
echo ""

echo ""
echo ""
echo "***********"
echo "Cleaning house..."
echo "***********"
echo ""
echo ""

sudo apt-get purge nvidia-*
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo ""
echo ""
echo "Done cleaning!"
echo ""
echo ""

echo ""
echo ""
echo "***********"
echo "Initializing file system..."
echo "***********"
echo ""
echo ""


rm -rf Templates Public Music Videos Examples Pictures examples.desktop
mkdir ~/Apps ~/Android ~/Code_Complete/ ~/.screenlayout
cp lib/config/1x2x1.sh ~/.screenlayout/

echo ""
echo ""
echo "File system initialized!"
echo ""
echo ""

echo ""
echo ""
echo "***********"
echo "Adding repositories..."
echo "***********"
echo ""
echo ""


# zsh-completions
# sudo sh -c "echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-completions/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/zsh-completions.list"

# Add zsh-completions repo key to apt
# wget -nv http://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/xUbuntu_16.04/Release.key -O Release.key
# sudo apt-key add - < Release.key

# Nvidia
sudo add-apt-repository -y ppa:graphics-drivers/ppa

# Git
sudo add-apt-repository -y ppa:git-core/ppa

# Java
sudo add-apt-repository -y ppa:webupd8team/java

# Timeshift
sudo apt-add-repository -y ppa:teejee2008/ppa


# Shutter
wget -q http://shutter-project.org/shutter-ppa.key -O- | sudo apt-key add -

echo ""
echo ""
echo "Repositories added!"
echo ""
echo ""

echo ""
echo ""
echo "***********"
echo "Updating..."
echo "***********"
echo ""
echo ""

sudo apt update -y

echo ""
echo ""
echo "Done updating!"
echo ""
echo ""

echo "***********"
echo "Updating Nvidia Drivers..."
echo "***********"
echo ""
echo ""

sudo apt-get install nvidia-375

echo ""
echo ""
echo "***********"
echo "Installing Software..."
echo "***********"
echo ""
echo ""

# Install Java

sudo apt install -y python-software-properties debconf-utils

sudo apt update -y

echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections

sudo apt install -y oracle-java8-installer

# System Apps + Tools
sudo apt install -y curl dconf-editor arandr pavucontrol unzip thunar shutter htop vim timeshift chromium-browser gksu

# Git
sudo apt install -y git git-core git-doc git-gui gitk

# CLI
sudo apt install -y fonts-powerline zsh zsh-completions

# Miscellaneous
sudo apt install -y
# screenkey

echo ""
echo ""
echo "Done installing software!"
echo ""
echo ""

git config --global user.email "joethorngren@gmail.com"
git config --global user.name "Joe Thorngren"

wget -O ~/Downloads/ideaIU-2017.1.3.tar.gz https://download.jetbrains.com/idea/ideaIU-2017.1.2.tar.gz
tar -zxvf ~/Downloads/ideaIU-2017.1.3.tar.gz -C ~/Apps/IntelliJ-2017.1.3
cp ././lib/intellij-settings.jar ~/intellij-settings.jar
cp ././lib/studio-settings.jar ~/studio-settings.jar

