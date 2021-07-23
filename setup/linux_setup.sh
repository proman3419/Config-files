#!/bin/bash

# >>> Run as the user that should be configured.
# >>> Remember to set hostname properly because depending on it different configs will be imported.
# >>> Look for available options in the linux directory.

# >>> Sudo privileges are required, steps for Debian:
# su -l
# adduser <your_username_here> sudo
# logout
# logout

# >>> Download the setup script.
# wget https://raw.githubusercontent.com/proman3419/Config-files/master/setup/linux_setup.sh

# >>> Add execute permission for the script.
# chmod +x linux_setup.sh

# >>> Run the script, it needs to be source instead of ./.
# source linux_setup.sh

echo ">>> Update apt cache"
sudo apt update
echo

echo ">>> Install git"
sudo apt --assume-yes install git
echo

echo ">>> Clone the repository with configs"
git clone https://github.com/proman3419/Config-files.git ~/Documents/configs
echo

echo ">>> Install Ansible"
sudo ~/Documents/configs/scripts/install_packages/ansible_install.sh
echo

echo ">>> Install Ansible requirements"
ansible-galaxy install -r ~/Documents/configs/ansible/requirements.yml
echo

echo ">>> Load base configs"
ansible-playbook ~/Documents/configs/ansible/update_configs_base.yml
echo

echo ">>> Source .bashrc and .profile"
source ~/.bashrc
source ~/.profile
echo

echo ">>> Run Ansible playbook that continues the setup"
ansible-playbook ~/Documents/configs/ansible/setup.yml -K
