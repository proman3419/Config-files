#!/bin/bash

echo ">>> Downloading a package"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
echo

echo ">>> Installing Chrome"
sudo apt --assume-yes install /tmp/google-chrome-stable_current_amd64.deb
