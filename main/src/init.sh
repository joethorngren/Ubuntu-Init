#!/bin/bash

# Install Git

sudo apt-get install git

git config --global user.name "Joe Thorngren"
git config --global user.email "joethorngren@gmail.com"

git clone https://github.com/joethorngren/Ubuntu-Init.git
cd Ubuntu-Init/
chmod +x start.sh
./start.sh

