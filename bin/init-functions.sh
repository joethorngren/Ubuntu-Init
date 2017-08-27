#!/bin/bash

source ~/Ubuntu-Init/main/src/bin/script-utils.sh

function setInstallDirectory() {
    echo "This script requires copying some existing files from the cloned repository to your system"
    read -p "Enter the path to the cloned Ubuntu-Init repository: " install_dir
    export UBUNTU_INIT_DIR=${install_dir}

}

function initializeFileSystem() {

    updateStatus "Initializing file system..."

    echo "Removing: ~/Templates ~/Public ~/Music ~/Videos ~/Examples ~/Pictures ~/examples.desktop"
    rm -rf ~/Templates ~/Public ~/Music ~/Videos ~/Examples ~/Pictures ~/examples.desktop
    mkdir ~/Apps ~/Android ~/Code_Complete/ ~/Resources ~/.screenlayout ~/bin ~/.local/share/fonts/

    # cp lib/config/1x2x1.sh ~/.screenlayout/

    read -p "Do you wish to configure LightHouse Web NAS (y/n)? " answer
    case ${answer:0:1} in
       y|Y )
	     configureLightHouseWebNas
	;;
    esac

    updateStatus "File system initialized!"
}

function configureLightHouseWebNas() {

    updateStatus "Configuring NAS shit..."

    sudo apt install -y cifs-utils nfs-common
    sudo mkdir ~/Archives
    sudo chown ${USER}:${USER} ~/Archives
    sudo mount -t nfs 192.168.1.100:/volume1/Archives ~/Archives

    # TODO: Have to mount after every reboot?
    # TODO: Error!
    # oh_henry@Aero-15:~/Ubuntu-Init/main/src/bin$ sudo mount -t nfs 192.168.1.100:/volume1/Archives ~/Archives/
    # mount.nfs: access denied by server while mounting 192.168.1.100:/volume1/Archives

}

function initializeRepositories() {

    updateStatus "Adding repositories..."

    read -p "Install laptop tools (tlp + touchpad indicator) (y/n)? " answer
    case ${answer:0:1} in
       y|Y )
	     addAptRepo "ppa:linrunner/tlp"
	     addAptRepo "ppa:atareao/atareao"
	     export INSTALL_LAPTOP_TOOLS=true
	;;
    esac

    displayNvidiaPrompt
    if [ -n "$INSTALL_NVIDIA" ]; then
        echo "Adding ppa:graphics-drivers/ppa"
        addAptRepo "ppa:graphics-drivers/ppa"
    else
        echo "Not installing Nvidia drivers, skipping ppa:graphics-drivers/ppa"
    fi

    echo "Adding ppa:git-core/ppa"
    addAptRepo "ppa:git-core/ppa"

    echo "Adding ppa:teejee2008/ppa"
    addAptRepo "ppa:teejee2008/ppa"

    addAptRepo "ppa:git-core/ppa"

    echo "Adding ppa:webupd8team/java"
    addAptRepo "ppa:webupd8team/java"

    echo "Adding ppa:git-core/ppa"
    addAptRepo "ppa:teejee2008/ppa"

    echo "Adding ppa:terrz/razerutils"
    addAptRepo "ppa:terrz/razerutils"

    echo "Adding ppa:lah7/polychromatic"
    addAptRepo "ppa:lah7/polychromatic"

    read -p "Do you wish to install Kdenlive (y/n)? " answer
    case ${answer:0:1} in
       y|Y )
	     echo "ppa:kdenlive/kdenlive-stable"
         addAptRepo "ppa:kdenlive/kdenlive-stable"
	     export INSTALL_KDEN=true
	;;
    esac

    read -p "Do you wish to install Audacity (y/n)? " answer
    case ${answer:0:1} in
      y|Y )
	    echo "Adding ppa:ubuntuhandbook1/audacity"
        addAptRepo "ppa:ubuntuhandbook1/audacity"
        export INSTALL_AUDACITY=true
	;;
    esac

    echo "Adding ppa:gwendal-lebihan-dev/hexchat-stable"
    addAptRepo "ppa:gwendal-lebihan-dev/hexchat-stable"

    echo "ppa:webupd8team/y-ppa-manager"
    addAptRepo "ppa:webupd8team/y-ppa-manager"

    echo "ppa:shutter/ppa"
    addAptRepo "ppa:shutter/ppa"

    # TODO: Add these?
    # SimpleScreenRecorder (ppa:inkscape.dev/stable)
    # OpenShot (ppa:openshot.developers/ppa)
    # GIMP (ppa:otto-kesselgulasch/gimp)
    # Inkscape (ppa:inkscape.dev/stable)

    addI3wmPpa
    addSpotifyPpa
    addNitrogenPpa

    updateStatus "Repositories added!"

    updateStatus "Updating..."
    sudo apt-get update
    updateStatus "Done Updating!"
}

function addI3wmPpa() {
    /usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb ~/bin/i3-keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
    sudo apt install -y ~/bin/i3-keyring.deb
    echo "deb http://debian.sur5r.net/i3/ xenial universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list
}


function addSpotifyPpa() {
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
}

function copyIntelliJAndStudioSettingsJars() {

    updateStatus "Copying IntelliJ and Android Studio JAR files..."

    cp ~/Ubuntu-Init/lib/config/intellij-settings.jar ~/intellij-settings.jar
    cp ~/Ubuntu-Init/lib/config/studio-settings.jar ~/studio-settings.jar

    updateStatus "Done Copying IntelliJ and Android Studio JAR files..."
}

function installAllTheThings() {

    updateStatus "Installing Software..."

    if [ -n "$INSTALL_NVIDIA" ]; then
        installNvidiaDrivers
    fi

    read -p "Do you wish to install low-latency sound + jack drivers (y/n)? " answer
    case ${answer:0:1} in
      y|Y )
	    installSoundShit
	;;
    esac

    if [ -n "${INSTALL_LAPTOP_TOOLS}" ]; then
        installLaptopTools
    fi

    installSystemUtils
    installGit
    installIntelliJ
    # installAndroidStudio
    installSlack
    installCalibre
    installI3wm
    installZsh
    installPowerLine
    installRazerUtils

    # Purgatory:
    # installKvm
    # installPomello
    # installAnki
    # TODO: screenkey, ubuntu-mate-welcome, zsh-completions

    updateStatus "Done Installing Software..."

}

function installNvidiaDrivers() {

    updateStatus "Purging Existing Nvidia Drivers..."

    sudo apt-get purge -y nvidia-*

    updateStatus "Done Purging Existing Nvidia Drivers..."

    updateStatus "Installing Nvdia ${NVIDIA_VERSION} Drivers"

    sudo apt install -y nvidia-${NVIDIA_VERSION}
    # TODO: update xorg.conf

    updateStatus "Done Installing Nvdia ${NVIDIA_VERSION} Drivers"
}

function installSoundShit() {

    updateStatus "Installing Sound Shit..."
    sudo apt install -y linux-lowlatency

    sudo apt install -y pulseaudio-module-jack pavucontrol paprefs

    # TODO: Kdenlive vs. kxstudio?
    if [ -n "$INSTALL_KDEN" ]; then
       echo "Installing kx studio"
       # installKxStudio
    fi

    if [ -n "$INSTALL_AUDACITY" ]; then
       sudo apt install -y audacity
    fi

    sudo apt install -y qjackctl # Jack install autoconfigures shit from Step #2 in:

    updateStatus "Done Installing Sound Shit"
}

function installLaptopTools() {
    sudo apt-get remove laptop-mode-tools
    sudo apt-get install -y tlp tlp-rdw smartmontools ethtool touchpad-indicator thermald

    # Start TLP Service for the first time only. You don’t need to start it on every reboot, it will start automatically:
    sudo tlp start

    # Enter the following command to see the detailed output of TLP:
    # sudo tlp stat
}

function installSystemUtils() {

    updateStatus "Installing curl, dconf-editor, arandr, unzip, htop, vim, & ukuu!"
    sudo apt install -y curl dconf-editor arandr unzip htop vim ukuu
    updateStatus "Done Installing curl, dconf-editor, arandr, unzip, htop, & vim!"

    updateStatus "Installing timeshift, gksu, keychain, terminator, y-ppa-manager, & synaptic!"
    sudo apt install -y timeshift gksu keychain terminator gksu terminator y-ppa-manager synaptic
    updateStatus "Done Installing timeshift, gksu, terminator, y-ppa-manager, & synaptic!"

    updateStatus "Installing kdenlive, kdenlive, chromium-browser, thunar, autokey, shutter, audacity, hexchat, & Spotify!"
    sudo apt install -y kdenlive chromium-browser thunar shutter hexchat spotify-client
    updateStatus "Done Installing kdenlive, kdenlive, chromium-browser, thunar, autokey, shutter, audacity, & Spotify!"

}

function installGit() {

    updateStatus "Installing git, git-core, git-doc, git-gui, & gitk"

    sudo apt install -y git git-core git-doc git-gui gitk

    updateStatus "Done Installing git, git-core, git-doc, git-gui, & gitk"

}

function installJava() {

    updateStatus "Installing Java!"

    # Install Java
    sudo apt install -y python-software-properties debconf-utils

    sudo apt update -y

    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections

    sudo apt install -y oracle-java8-installer

    updateStatus "Done Installing Java!"

}

function installI3wm() {

    updateStatus "Installing i3!"

    sudo apt update -y
    sudo apt install -y -f i3 i3blocks i3status i3lock rofi nitrogen compton lightdm-gtk-greeter lightdm-gtk-greeter-settings
    # Themes/Appearance
    sudo apt-get install -y lxappearance gtk-chtheme qt4-qtconfig gtk2-engines-murrine gtk2-engines-pixbuf
    # sudo apt-get install -y paper-icon-theme paper-gtk-theme paper-cursor-theme

    sudo apt dist-upgrade -y

    sudo dpkg -i ./lib/res/deb/playerctl-0.5.0_amd64.deb

    # Kill Unity
    # updateStatus "Installing i3: Killing Unity"
    # sudo apt autoremove --purge -y compiz compiz-gnome compiz-plugins-default libcompizconfig0
    # sudo apt autoremove --purge -y unity unity-common unity-services libunity-misc4 appmenu-gtk
    # sudo apt autoremove --purge -y appmenu-gtk3 appmenu-qt overlay-scrollbar activity-log-manager-control-center firefox-globalmenu thunderbird-globalmenu
    sudo apt autoremove
    sudo apt autoclean

    # updateStatus "Installing i3: Done Killing Unity!"
    # the following command will disable the desktop (we won't need it with i3!)
    gsettings set org.gnome.desktop.background show-desktop-icons false

    updateStatus "Done Installing i3!"

}

function installZsh() {

    updateStatus "Installing ZSH!"

    sudo apt install -y zsh zsh-doc
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    updateStatus "Done Installing ZSH!"
}

function installPowerLine() {

    updateStatus "Installing PowerLine!"

    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    mkdir ~/.local/share/fonts/nerd-fonts
    export NERD_FONT_DIR=~/.local/share/fonts/nerd-fonts
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts ${NERD_FONT_DIR}/nerd-fonts
    cd ${NERD_FONT_DIR}
    ./install.sh

    updateStatus "Done Installing PowerLine!"

}

function initializeDotFiles() {

    updateStatus "Initializing Dot Files!"

    git clone --bare https://github.com/joethorngren/Dotfiles.git ~/.dotfiles/
    alias dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"
    dotfiles config status.showUntrackedFiles no
    dotfiles checkout

    updateStatus "Done Initializing Dot Files!"

}

function installIntelliJ() {

	updateStatus "Installing IntelliJ!"

    wget -O ~/Downloads/ideaIU-2017.2.2.tar.gz https://download.jetbrains.com/idea/ideaIU-2017.2.2.tar.gz
    cd ~/Downloads/
    tar -zxvf ~/Downloads/ideaIU-2017.2.2.tar.gz
    mv ~/Downloads/idea-IU-171.4694.70 ~/Apps/IntelliJ

	updateStatus "Done Installing IntelliJ!"
}

function installAndroidStudio() {

	updateStatus "Installing Android Studio!"

    sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

    cd ~/Apps/
    wget https://dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio-ide-162.4069837-linux.zip
    wget https://dl.google.com/dl/android/studio/ide-zips/3.0.0.10/android-studio-ide-171.4263559-linux.zip

    unzip android-studio-ide-162.4069837-linux.zip
    mv android-studio Android-Studio-Stable
    unzip android-studio-ide-171.4263559-linux.zip
    mv android-studio Android-Studio-Canary

    updateStatus "Done Installing Android Studio!"

}

function installSlack() {

	updateStatus "Installing Slack!"

    wget -O ~/Downloads/slack-desktop-2.6.3-amd64.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.3-amd64.deb
    sudo dpkg -i ~/Downloads/slack-desktop-2.6.3-amd64.deb
    sudo apt -fy install

    updateStatus "Done Installing Slack!"

}

function installCalibre() {

    updateStatus "Installing Calibre!"

    wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda x,y:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('~/Apps/', True)"
    mv ~/Apps/calibre/ ~/Apps/Calibre/

    updateStatus "Done Installing Calibre!"

}

function installAnki() {

    updateStatus "Installing Anki!"

    tar xjf main/src/lib/res/anki-2.0.45-amd64.tar.bz2
    mv anki-2.0.45 ~/Apps/
    mv ~/Apps/anki-2.0.45/ ~/Apps/Anki-2.0.45

    updateStatus "Done Installing Anki!"

}

function installRazerUtils() {

    sudo apt-get install -y python3-razer razer-kernel-modules-dkms razer-daemon razer-doc
    sudo apt-get install -y polychromatic

}