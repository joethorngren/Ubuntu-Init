# Install Slack

wget -O ~/Downloads/slack-desktop-2.6.0-amd64.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.0-amd64.deb
sudo dpkg -i ~/Downloads/slack-desktop-2.6.0-amd64.deb
sudo apt -fy install

# Install Calibre

wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda x,y:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('~/Apps/', True)"

# Z-Shell

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# i3 Shizz

/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
sudo apt install ./keyring.deb

echo ""

sudo sh -c 'cat  deb http://debian.sur5r.net/i3/ xenial universe > /etc/apt/sources.list.d/sur5r-i3.list'

sudo apt update -y
sudo apt install -y -f i3 i3blocks i3status i3lock nitrogen compton
# ubuntu-mate-welcome

sudo dpkg -i ./lib/res/deb/playerctl-0.5.0_amd64.deb

# Kill Unity

sudo apt-get autoremove --purge compiz compiz-gnome compiz-plugins-default libcompizconfig0
sudo apt-get autoremove --purge unity unity-common unity-services libunity-core-6 libunity-misc4 appmenu-gtk appmenu-gtk3 appmenu-qt overlay-scrollbar activity-log-manager-control-center firefox-globalmenu thunderbird-globalmenu

# the following command will disable the desktop (we won't need it with i3!)
gsettings set org.gnome.desktop.background show-desktop-icons false

# reboot
