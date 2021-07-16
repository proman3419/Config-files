#!/bin/bash

if !(grep -q "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" /etc/apt/sources.list); then
    printf ">>> Append to /etc/apt/sources.list"
    printf "\n# ansible\ndeb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main\n" | sudo tee -a /etc/apt/sources.list
    echo
fi

echo ">>> Add a key"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
echo

echo ">>> Update apt cache"
sudo apt update
echo

echo ">>> Install ansible"
sudo apt --assume-yes install ansible
