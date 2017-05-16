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

sudo apt-get autoremove
sudo apt-get autoclean

reboot
