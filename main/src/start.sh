#!/bin/bash

source ./script-utils.sh
source ./init-functions.sh

updateStatus "Turning on Debugging!"
set -x

autoRemoveAndClean

displayNvidiaPrompt

initializeRepositories

updateAllTheThings
installAllTheThings

copyIntelliJAndStudioSettingsJars

continuePrompt
initializeDotFiles

updateStatus "Turning off Debugging!"
set +x
