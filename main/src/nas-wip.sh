#!/bin/bash

# NAS Shit...

# TODO: Use whatever the username is...

sudo apt install cifs-utils nfs-common
sudo mkdir /media/dayfun/Archives
sudo chown dayfun:dayfun /media/dayfun/Archives
sudo mount -t nfs 192.168.1.100:/volume1/Archives /media/dayfun/Archives

# TODO: Figure out what to do with .desktop file + i3?
# TODO: Update Icon + update to whatever username is...
# TODO: Symbolic link to shared drives + folders in Home Directory?
# TODO: Have to mount after every reboot?