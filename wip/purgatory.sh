#!/usr/bin/env bash

function installHub() {
    tar zvxvf hub-linux-amd64-2.3.0-pre9.tgz
    mv lib/res/hub-linux-amd64-2.3.0-pre9 ~/Apps/Hub
    sudo ~/Apps/Hub/install

    # Setup autocomplete for zsh:
    mkdir -p ~/.zsh/completions
    mv ./hub-linux-amd64-2.2.5/etc/hub.zsh_completion ~/.zsh/completions/_hub
    echo "fpath=(~/.zsh/completions $fpath)" >> ~/.zshrc
    echo "autoload -U compinit && compinit" >> ~/.zshrc

    # add alias
    echo "eval "$(hub alias -s)"" >> ~/.zshrc

    # Cleanup
    rm -rf hub-linux-amd64-2.2.5
}

function installArcTheme() {
    sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/arc-theme.list"
    sudo apt-get update
    sudo apt-get install arc-theme

    sudo apt-key add - < /lib/res/arc-theme.key
    sudo apt-get update
}

function installKxStudio() {
    # TODO: Already installed???

    # Install required dependencies if needed
    sudo apt-get install -y libglibmm-2.4-1v5

    # Download package file
    wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos-gcc5_9.4.1~kxstudio1_all.deb

    # Install it
    sudo dpkg -i kxstudio-repos-gcc5_9.4.1~kxstudio1_all.deb
}

function installPomello() {
   # TODO: figure out how to convert link from website (https://pomelloapp.com/download/linux?package=deb&arch=64) to wget
   # TODO: for now, using 0.8.2 located in src/lib/res
   # sudo dpkg -i
   echo "Installing Pomello!"
}

function installKvm() {

	updateStatus "Installing Kvm!"

    sudo apt install -y qemu-kvm libvirt0 libvirt-bin virt-manager bridge-utils
    sudo systemctl enable libvirt-bin

    updateStatus "Done Installing Kvm!"

}

# don't think I need this...
function addNitrogenPpa() {
    echo "deb http://ppa.launchpad.net/k-belding/ubuntu intrepid main" | sudo tee /etc/apt/sources.list.d/nitrogen.list
}