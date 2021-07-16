#!/bin/bash

#-------------------------------------------------------------------------------
# Data
#-------------------------------------------------------------------------------

# Parameters:
# $1 - url
# $2 - path to the output file
# $3 - package name (output only, no need to be exact)
mandatory_args_cnt=3
url=$1
path=$2
package_name=$3


#-------------------------------------------------------------------------------
# Logic
#-------------------------------------------------------------------------------

print_help() {
    echo "Usage: wget_installer.sh [URL] [PATH] [PACKAGE_NAME]"
    echo "Downloads .deb package from URL, saves in PATH and installs it."
    echo

    echo "PACKAGE_NAME is only outputed, it doesn't need to be exact."
}

read_flags() {
    if [[ $1 == "--help" ]]; then
        print_help
        exit 0
    fi

    if [[ $# -lt $mandatory_args_cnt ]]; then
        echo "Missing argument(s)"
        exit 1
    fi
}

read_flags "$@"

echo ">>> Download a package"
wget "$url" -O "$path"
echo

echo ">>> Install $package_name"
sudo apt --assume-yes install "$path"
