#!/bin/bash

function updateStatus() {

    echo ""
    echo ""
    echo "***********"
    echo "$1"
    echo "***********"
    echo ""
    echo ""

}

function updateAllTheThings() {

    updateStatus "Updating & Upgrading..."

    sudo apt update -y
    sudo apt upgrade -y
    sudo apt dist-upgrade -y

    updateStatus "Done Updating & Upgrading!"

}

function autoRemoveAndClean() {

    updateStatus "Cleaning up!"

    sudo apt-get autoremove -y
    sudo apt-get autoclean -y

    updateStatus "Done Cleaning up!"
}

function addAptRepo() {

    sudo apt-add-repository -y "$1"

}

function initializeFileSystem() {

    updateStatus "Initializing file system..."

    rm -rf ~/Templates ~/Public ~/Music ~/Videos ~/Examples ~/Pictures ~/examples.desktop
    mkdir ~/Apps ~/Android ~/Code_Complete/ ~/.screenlayout ~/bin
    cp lib/config/1x2x1.sh ~/.screenlayout/

    updateStatus "File system initialized!"
}

function copyIntelliJAndStudioSettingsJars() {

    updateStatus "Copying IntelliJ and Android Studio JAR files..."

    cp lib/config/intellij-settings.jar ~/intellij-settings.jar
    cp lib/config/studio-settings.jar ~/studio-settings.jar

    updateStatus "Done Copying IntelliJ and Android Studio JAR files..."
}


function displayNvidiaPrompt() {

    echo "Do you wish to install this NVIDIA drivers (y/n)?" answer
    case ${answer:0:1} in
        y|Y )
            export INSTALL_NVIDIA=true
        ;;
        * )

        ;;
    esac

}

function initializeRepositories() {

    updateStatus "Adding repositories..."


    if [ -n "$INSTALL_NVIDIA" ]; then
        echo "Adding ppa:graphics-drivers/ppa"
        addAptRepo "ppa:graphics-drivers/ppa";           # Nvidia
    else
        echo "Not installing Nvidia drivers, skipping ppa:graphics-drivers/ppa"
    fi


    echo "Adding ppa:git-core/ppa"
    addAptRepo "ppa:git-core/ppa"                   # Git

    echo "Adding ppa:webupd8team/java"
    addAptRepo "ppa:webupd8team/java"               # Java

    echo "Adding ppa:git-core/ppa"
    addAptRepo "ppa:teejee2008/ppa"                 # Timeshift

    echo "ppa:kdenlive/kdenlive-stable"
    addAptRepo "ppa:kdenlive/kdenlive-stable"       # KdenLive

    echo "Adding ppa:ubuntuhandbook1/audacity"
    addAptRepo "ppa:ubuntuhandbook1/audacity"       # Audacity


    # Paper Icon Theme
    # sudo add-apt-repository -y ppa:snwh/pulp

    # Arc Theme
    sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/arc-theme.list"

    # Shutter
    wget -q http://shutter-project.org/shutter-ppa.key -O- | sudo apt-key add -

    updateStatus "Repositories added!"

}

function installNvidiaDrivers() {

    if [ -n "$INSTALL_NVIDIA" ]; then
        updateStatus "Purging Existing Nvidia Drivers..."

        sudo apt-get purge -y nvidia-*

        updateStatus "Done Purging Existing Nvidia Drivers..."

        updateStatus "Installing Nvdia 375 Drivers"

        sudo apt install -y nvidia-375
        # TODO: update xorg.conf

        updateStatus "Done Installing Nvdia 375 Drivers"
    fi

}

function installSoftware() {

    updateStatus "Installing Software..."

    installSystemSoftware
    installGit
    installIntelliJ
    installAndroidStudio
    installKvm
    installSlack
    installCalibre
    installAnki
    installZsh
    installI3

    # Purgatory:
    # screenkey, ubuntu-mate-welcome, zsh-completions

    updateStatus "Done Installing Software..."

}

function installSystemSoftware() {

    updateStatus "Installing curl, dconf-editor, arandr, pavucontrol, unzip, htop, vim, timeshift, gksu, & terminator!"

    sudo apt install -y curl dconf-editor arandr pavucontrol unzip htop vim timeshift  gksu terminator

    updateStatus "Done Installing curl, dconf-editor, arandr, pavucontrol, unzip, htop, vim, timeshift, gksu, & terminator!"

    updateStatus "Installing kdenlive, kdenlive, chromium-browser, thunar, shutter, & audacity!"

    sudo apt install -y kdenlive chromium-browser thunar shutter audacity

    updateStatus "Done Installing kdenlive, kdenlive, chromium-browser, thunar, shutter, & audacity!"

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


function installPowerLine() {

    updateStatus "Installing PowerLine!"

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

    updateStatus "Done Installing PowerLine!"

}

function installZsh() {

    updateStatus "Installing ZSH!"

    sudo apt install -y zsh zsh-doc
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    updateStatus "Done Installing ZSH!"


}

function installI3() {

    updateStatus "Installing i3!"

    /usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb ~/bin/i3-keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
    sudo apt install -y ~/bin/i3-keyring.deb

    echo "deb http://debian.sur5r.net/i3/ xenial universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list

    sudo apt update -y
    sudo apt install -y -f i3 i3blocks i3status i3lock rofi nitrogen compton lightdm-gtk-greeter lightdm-gtk-greeter-settings
    # Themes/Appearance
    sudo apt-get install -y lxappearance gtk-chtheme qt4-qtconfig gtk2-engines-murrine gtk2-engines-pixbuf
    sudo apt-get install -y paper-icon-theme paper-gtk-theme paper-cursor-theme


    sudo apt dist-upgrade -y

    sudo dpkg -i ./lib/res/deb/playerctl-0.5.0_amd64.deb

    # Kill Unity
    updateStatus "Installing i3: Killing Unity"
    sudo apt autoremove --purge -y compiz compiz-gnome compiz-plugins-default libcompizconfig0
    sudo apt autoremove --purge -y unity unity-common unity-services libunity-misc4 appmenu-gtk
    sudo apt autoremove --purge -y appmenu-gtk3 appmenu-qt overlay-scrollbar activity-log-manager-control-center firefox-globalmenu thunderbird-globalmenu
    sudo apt autoremove
    sudo apt autoclean

    updateStatus "Installing i3: Done Killing Unity!"
    # the following command will disable the desktop (we won't need it with i3!)
    gsettings set org.gnome.desktop.background show-desktop-icons false

    updateStatus "Done Installing i3!"

}

function initializeDotFiles() {

    updateStatus "Initializing Dot Files!"

    git clone --bare https://github.com/joethorngren/Dotfiles.git .dotfiles/
    alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    dotfiles config status.showUntrackedFiles no

    updateStatus "Done Initializing Dot Files!"

}

function installIntelliJ() {

	updateStatus "Installing IntelliJ!"

    wget -O ~/Downloads/ideaIU-2017.1.3.tar.gz https://download.jetbrains.com/idea/ideaIU-2017.1.3.tar.gz
    mkdir ~/Apps/IntelliJ-2017.1.3

    # TODO: Has to be a better way to do this...
    cp -r Apps/IntelliJ-2017.1.3/idea-IU-171.4249.39/* Apps/IntelliJ-2017.1.3
    rm -rf Apps/IntelliJ-2017.1.3/idea-IU-171.4249.39 ~/Downloads/ideaIU-2017.1.3.tar.gz
    tar -zxvf ~/Downloads/ideaIU-2017.1.3.tar.gz -C ~/Apps/IntelliJ-2017.1.3

	updateStatus "Done Installing IntelliJ!"
}

function installAndroidStudio() {

	updateStatus "Installing Android Studio!"

    sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
    mkdir ~/Apps/Android-Studio
    # TODO: Download + Unzip + move to newly created dir on line #186

    updateStatus "Done Installing Android Studio!"

}

function installKvm() {

	updateStatus "Installing Kvm!"

    sudo apt install -y qemu-kvm libvirt0 libvirt-bin virt-manager bridge-utils
    sudo systemctl enable libvirt-bin

    updateStatus "Done Installing Kvm!"

}

function installSlack() {

	updateStatus "Installing Slack!"

    wget -O ~/Downloads/slack-desktop-2.6.0-amd64.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.0-amd64.deb
    sudo dpkg -i ~/Downloads/slack-desktop-2.6.0-amd64.deb
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

updateAllTheThings
autoRemoveAndClean

displayNvidiaPrompt
initializeRepositories
installNvidiaDrivers


updateAllTheThings


installSoftware

copyIntelliJAndStudioSettingsJars
initializeDotFiles

