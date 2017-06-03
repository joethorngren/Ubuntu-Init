#!/bin/bash
# Record
#
# Basic variable assignment
episode_path="/home/willdu/episodes"
#
# Enter episode root directory
cd $episode_path
#
# Get episode number
read -p "What is the episode number? " episode
echo "You entered Episode " $episode
#
# Check if directory exists, create if it doesn't.
if [ ! -d "$episode" ]; then
mkdir "$episode"
fi
#
# Enter episode directory
cd $episode
#
# Determine recording parameters
read -p "How many mics are you using? " mics
#
# Check if ready to record
while true; do
read -p "Would you like to start recording? " yn
case $yn in
[Yy]* ) : ; break;;
[Nn]* ) exit;;
* ) echo "Please answer yes or no.";;
esac
done
#
# Start recording
while true; do
case $mics in
1 ) jack_capture -f flac --port jack_mixer:'VLC Out' --port jack_mixer:'Mic1 Out' --port jack_mixer:'Desktop Out L' --port jack_mixer:'Desktop Out R' --port jack_mixer:'Zeus Out'; break;;
2 ) jack_capture -f flac --port jack_mixer:'VLC Out' --port jack_mixer:'Mic1 Out' --port jack_mixer:'Mic2 Out' --port jack_mixer:'Desktop Out L' --port jack_mixer:'Desktop Out R' --port jack_mixer:'Zeus Out'; break;;
3 ) jack_capture -f flac --port jack_mixer:'VLC Out' --port jack_mixer:'Mic1 Out' --port jack_mixer:'Mic2 Out' --port jack_mixer:'Mic3 Out' --port jack_mixer:'Desktop Out L' --port jack_mixer:'Desktop Out R' --port jack_mixer:'Zeus Out'; break;;
* ) echo "Please provide a number when you try again."; break;;
esac
done
#
# Wait for response before closing window.
while true; do
read -p "Press any key to exit." y
case $y in
* ) : ; exit;;
esac
done
exit