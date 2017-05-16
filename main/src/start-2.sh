#!/bin/bash

rm -rf Templates Public Music Videos Examples Pictures examples.desktop
mkdir ~/Apps ~/Android ~/Code_Complete/

sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-add-repository -y ppa:teejee2008/ppa

sudo apt-get update -y

sudo apt-get install -y arandr pavucontrol unzip thunar htop vim git git-core chromium-browser timeshift fonts-powerline zsh zsh-completions oracle-java8-installer
