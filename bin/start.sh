#!/bin/bash

echo "This script requires copying some existing files from the cloned repository to your system"
read -p "Enter the path to the cloned Ubuntu-Init repository: " installDir
export UBUNTU_INIT_DIR=${installDir}

source ${UBUNTU_INIT_DIR}/script-utils.sh
source ${UBUNTU_INIT_DIR}/init-functions.sh

#updateAllTheThings
#autoRemoveAndClean
#
#initializeFileSystem
#initializeRepositories
#
#installAllTheThings
#
#copyIntelliJAndStudioSettingsJars
#
#initializeDotFiles
