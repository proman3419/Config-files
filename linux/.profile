#-------------------------------------------------------------------------------
# Defaults
#-------------------------------------------------------------------------------

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


#-------------------------------------------------------------------------------
# Environment variables
#-------------------------------------------------------------------------------

# Constant paths
export SCRIPTS_DIR='/home/przemek/Documents/configs/linux/scripts'
export TEMPLATES_DIR='/home/przemek/Documents/configs/templates'

# Temporary paths
export ASD_REPO_DIR='/home/przemek/Documents/agh/semestr_2/asd/asd_repo'

# Add to PATH
export PATH="$PATH:/opt"
export PATH="$PATH:/usr/bin/js"
export PATH="$PATH:/usr/share/playonlinux/playonlinux"
export PATH="$PATH:$HOME/Documents/soldat/local_server"
export PATH="${PATH}:${SCRIPTS_DIR}" # Add scripts directory to PATH
export PATH="$PATH:$HOME/.rvm/bin" # Make sure this is the last PATH variable

# Other variables
export JAVA_HOME="/usr/bin/java"
