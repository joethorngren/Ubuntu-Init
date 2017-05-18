#!/bin/bash

# sh test-start-after-clean.sh

echo "***********"
echo "Updating Nvidia Drivers..."
echo "***********"
echo ""
echo ""

sudo ubuntu-drivers autoinstall

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
cp 

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

sudo apt-get install -y python-software-properties debconf-utils

sudo apt-get update -y

echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections

sudo apt-get install -y oracle-java8-installer curl dconf-editor arandr pavucontrol unzip thunar nitrogen compton shutter htop vim git git-core chromium-browser fonts-powerline zsh zsh-completions timeshift

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

# Install Slack

wget -O ~/Downloads/slack-desktop-2.6.0-amd64.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.0-amd64.deb
sudo dpkg -i ~/Downloads/slack-desktop-2.6.0-amd64.deb
sudo apt-get -fy install

# Install Calibre

wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda x,y:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('~/Apps/', True)"

# Z-Shell

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## i3

/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
sudo apt install ./keyring.deb

echo ""

sudo sh -c 'cat  deb http://debian.sur5r.net/i3/ xenial universe > /etc/apt/sources.list.d/sur5r-i3.list'

sudo apt update -y
sudo apt install -y -f i3 i3blocks i3status i3lock

reboot

