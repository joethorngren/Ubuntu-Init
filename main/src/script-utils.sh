#!/bin/bash

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

function updateStatus() {

    echo ""
    echo ""
    echo "***********"
    echo "$1"
    echo "***********"
    echo ""
    echo ""

}

function continuePrompt() {

    read -p "Do you wish to continue? " answer
    case ${answer:0:1} in
        y|Y )
            export CONTINUE="yes"
        ;;
        * )
            return 255
        ;;
    esac

}