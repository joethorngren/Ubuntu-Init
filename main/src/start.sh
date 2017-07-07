#!/bin/bashupdateStatus "Turning on Debugging!"
set -x

updateAllTheThings

continuePrompt
autoRemoveAndClean

continuePrompt
displayNvidiaPrompt

continuePrompt
initializeRepositories

continuePrompt
installNvidiaDrivers

continuePrompt
updateAllTheThings

continuePrompt
installSoftware

continuePrompt
copyIntelliJAndStudioSettingsJars

continuePrompt
initializeDotFiles

updateStatus "Turning off Debugging!"
set +x
