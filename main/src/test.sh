#!/usr/bin/env bash

sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/arc-theme.list"
sudo apt-get update
sudo apt-get install arc-theme

sudo apt-key add - < /lib/res/arc-theme.key
sudo apt-get update
