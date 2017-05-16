#!/bin/bash

rm -rf Templates Public Music Videos Examples Pictures examples.desktop
mkdir ~/Apps ~/Android ~/Code_Complete/

# zsh-completions
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-completions/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/zsh-completions.list"

# Add zsh-completions repo key to apt
wget -nv http://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/xUbuntu_16.04/Release.key -O Release.key
sudo apt-key add - < Release.key

sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:webupd8team/java
# sudo apt-add-repository -y ppa:teejee2008/ppa

sudo apt-get update -y

sudo apt-get install -y arandr pavucontrol unzip thunar htop vim git git-core chromium-browser  fonts-powerline zsh zsh-completions oracle-java8-installer

# timeshift
