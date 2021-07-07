#!/bin/bash

cd ~/xubuntu-xibo-player/

# Copy Xibo config and launch options window
echo "Configuring Xibo-Player"
# mkdir ~/snap/
mkdir ~/snap/xibo-player/
mkdir ~/snap/xibo-player/current/
mkdir ~/snap/xibo-player/common/
mkdir ~/snap/xibo-player/common/resources/
ln -s ~/.Xauthority ~/snap/xibo-player/current/.Xauthority
cp cmsSettings.xml ~/snap/xibo-player/common/cmsSettings.xml
echo "Opening Xibo Player options"
echo "Press save!"
xibo-player.options

# Enable autostart
echo "Configuring autostart of Xibo-Player"
mkdir ~/.config/autostart/
cp xiboplayer.desktop ~/.config/autostart/xiboplayer.desktop

