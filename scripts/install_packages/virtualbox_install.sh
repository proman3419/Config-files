#!/bin/bash

echo ">>> Add a key"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo

echo ">>> Add a repository"
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
echo

echo ">>> Update apt cache"
sudo apt update
echo

echo ">>> Install VirtualBox"
sudo apt install virtualbox-6.0
