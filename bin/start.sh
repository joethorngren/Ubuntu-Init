#!/bin/bash

echo "This script requires copying some existing files from the cloned repository to your system"
echo "Type enter to leave the default value of \${HOME}/Ubuntu-Init"
read -p "Enter the path to the cloned Ubuntu-Init repository: " installDir
export UBUNTU_INIT_DIR=${installDir:-${HOME}/Ubuntu-Init}

source ${UBUNTU_INIT_DIR}/bin/script-utils.sh
source ${UBUNTU_INIT_DIR}/bin/init-functions.sh

#installAndroidStudio

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
