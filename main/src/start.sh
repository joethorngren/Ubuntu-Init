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


rm -rf ~/Templates ~/Public ~/Music ~/Videos ~/Examples ~/Pictures ~/examples.desktop
mkdir ~/Apps ~/Android ~/Code_Complete/ ~/.screenlayout ~/bin
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

sudo apt install -y nvidia-375
# TODO: update xorg.conf

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
sudo apt install -y curl dconf-editor arandr pavucontrol unzip thunar shutter htop vim timeshift chromium-browser gksu terminator

# Git
sudo apt install -y git git-core git-doc git-gui gitk

# Purgatory:
#             screenkey, ubuntu-mate-welcome, zsh-completions

echo ""
echo ""
echo "Done installing software!"
echo ""
echo ""

git config --global user.email "joethorngren@gmail.com"
git config --global user.name "Joe Thorngren"

# IntelliJ

wget -O ~/Downloads/ideaIU-2017.1.3.tar.gz https://download.jetbrains.com/idea/ideaIU-2017.1.2.tar.gz
mkdir ~/Apps/IntelliJ-2017.1.3

# TODO: Has to be a better way to do this... 
cp -r Apps/IntelliJ-2017.1.3/idea-IU-171.4249.39/* Apps/IntelliJ-2017.1.3 
rm -rf Apps/IntelliJ-2017.1.3/idea-IU-171.4249.39 ~/Downloads/ideaIU-2017.1.3.tar.gz

tar -zxvf ~/Downloads/ideaIU-2017.1.3.tar.gz -C ~/Apps/IntelliJ-2017.1.3
cp lib/config/intellij-settings.jar ~/intellij-settings.jar

cp lib/config/studio-settings.jar ~/studio-settings.jar

# Android Studio

sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
mkdir ~/Apps/Android-Studio
# TODO: Download + Unzip + move to newly created dir on line #186

# KVM:

sudo apt install -y qemu-kvm libvirt0 libvirt-bin virt-manager bridge-utils
sudo systemctl enable libvirt-bin

# Install Slack

wget -O ~/Downloads/slack-desktop-2.6.0-amd64.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.0-amd64.deb
sudo dpkg -i ~/Downloads/slack-desktop-2.6.0-amd64.deb
sudo apt -fy install

# Install Calibre

wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda x,y:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('~/Apps/', True)"
mv ~/Apps/calibre/ ~/Apps/Calibre/

# Z-Shell

# CLI
sudo apt install -y zsh zsh-doc
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Powerline

sudo apt-get install  -y python-pip
pip install --upgrade pip
sudo apt-get upgrade -y
pip install git+git://github.com/Lokaltog/powerline

# Inside fonts dir
# wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
# wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

# Move to fonts dir: can find via
#       xset -q
# TODO: Should I be using this fonts directory, or create and use one from ~/.fonts?
sudo cp lib/res/fonts/PowerlineSymbols.otf /usr/share/fonts/opentype/
fc-cache -vf /usr/share/fonts/
sudo cp lib/res/fonts/10-powerline-symbols.conf /etc/fonts/conf.d/

# i3 Shizz

/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb ~/bin/i3-keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
sudo apt install -y ~/bin/i3-keyring.deb

echo "deb http://debian.sur5r.net/i3/ xenial universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list

sudo apt update -y
sudo apt install -y -f i3 i3blocks i3status i3lock rofi nitrogen compton lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo apt dist-upgrade -y

sudo dpkg -i ./lib/res/deb/playerctl-0.5.0_amd64.deb

# Kill Unity

sudo apt autoremove --purge -y compiz compiz-gnome compiz-plugins-default libcompizconfig0
sudo apt autoremove --purge -y unity unity-common unity-services libunity-misc4 appmenu-gtk appmenu-gtk3 appmenu-qt overlay-scrollbar activity-log-manager-control-center firefox-globalmenu thunderbird-globalmenu
sudo apt autoremove
sudo apt autoclean

# the following command will disable the desktop (we won't need it with i3!)
gsettings set org.gnome.desktop.background show-desktop-icons false

# Dotfiles

git clone --bare https://github.com/joethorngren/Dotfiles.git .dotfiles/
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
dotfiles config status.showUntrackedFiles no

# reboot
