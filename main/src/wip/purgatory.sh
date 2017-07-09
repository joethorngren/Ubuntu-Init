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