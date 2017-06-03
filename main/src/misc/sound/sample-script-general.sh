#!/bin/bash
# Record
#
# Determine recording parameters
#read -p "How many mics are you using? " mics
#
# Start recording
while true; do
read -p "Would you like to start recording? " yn
case $yn in
[Yy]* ) : ; break;;
[Nn]* ) exit;;
* ) echo "Please answer yes or no.";;
esac
done
while true; do
case $mics in
1 ) jack_capture -f flac --port system:capture_1 --port system:playback_1 --port system:playback_2; break;;
2 ) jack_capture -f flac --port system:capture_1 --port system:capture_2 --port system:playback_1 --port system:playback_2; break;;
3 ) jack_capture -f flac --port system:capture_1 --port system:capture_2 --system:capture_3 --port system:playback_1 --port system:playback_2; break;;
* ) echo "Please provide a number when you try again."; break;;
esac
done
while true; do
read -p "Press any key to close this window." y
case $y in
* ) : ; exit;;
esac
done
exit