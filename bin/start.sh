#!/bin/bash

source ./script-utils.sh
source ./init-functions.sh

updateStatus "Turning on Debugging!"
set -x

updateAllTheThings
autoRemoveAndClean

initializeFileSystem
initializeRepositories

installAllTheThings

copyIntelliJAndStudioSettingsJars

initializeDotFiles

updateStatus "Turning off Debugging!"
set +x
