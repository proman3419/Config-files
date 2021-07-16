#!/bin/bash

echo ">>> Add a key"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo

echo ">>> Ensure apt is set up to work with https sources"
sudo apt-get install apt-transport-https
echo

echo ">>> Select the stable channel to use"
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo

echo ">>> Update apt cache"
sudo apt-get update
echo

echo ">>> Install sublime-text"
sudo apt-get --assume-yes install sublime-text
