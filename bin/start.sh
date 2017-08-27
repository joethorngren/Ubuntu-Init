#!/bin/bash

source ./script-utils.sh
source ./init-functions.sh

setInstallDirectory
updateAllTheThings
autoRemoveAndClean

initializeFileSystem
initializeRepositories

installAllTheThings

copyIntelliJAndStudioSettingsJars

initializeDotFiles
