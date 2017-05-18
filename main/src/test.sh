#!/bin/bash

# NAS Shit...

sudo apt install cifs-utils nfs-common
sudo mount -t nfs 192.168.1.100:/volume1/Archives /mnt/Archives

