#!/bin/bash

sudo apt-get update && sudo apt-get upgrade

git clone https://github.com/joethorngren/Ubuntu-Init.git
cd Ubuntu-Init/
chmod +x start.sh
./start.sh

