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
mkdir ~/Apps ~/Android ~/Code_Complete/

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
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-completions/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/zsh-completions.list"

# Add zsh-completions repo key to apt
wget -nv http://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/xUbuntu_16.04/Release.key -O Release.key
sudo apt-key add - < Release.key

sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:webupd8team/java
# sudo apt-add-repository -y ppa:teejee2008/ppa

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

sudo apt-get update -y

echo ""
echo ""
echo "Done updating!"
echo ""
echo ""

echo ""
echo ""
echo "***********"
echo "Installing Software..."
echo "***********"
echo ""
echo ""

sudo apt-get install -y arandr pavucontrol unzip thunar htop vim git git-core chromium-browser  fonts-powerline zsh zsh-completions oracle-java8-installer

# timeshift

echo ""
echo ""
echo "Done installing software!"
echo ""
echo ""
