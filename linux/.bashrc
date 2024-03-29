#-------------------------------------------------------------------------------
# Defaults
#-------------------------------------------------------------------------------

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#-------------------------------------------------------------
# Colors
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

# Colors for PS1
# It's required that colors have \[ in front and \] at the end.
function CPS1() {
    echo "\["$1"\]"
}


#-------------------------------------------------------------
# Environment variables
#-------------------------------------------------------------

# HOME paths
export RUNTIME_FILES_DIR="$HOME/.runtime_files"
export RUNTIME_INPUT_FILE="$RUNTIME_FILES_DIR/input"
export RUNTIME_OUTPUT_FILE="$RUNTIME_FILES_DIR/output"
export RUNTIME_COMPILED_FILE="$RUNTIME_FILES_DIR/compiled"

# DATA_DIR paths
export DATA_DIR="/media/shared" # where the partition with data is mounted
export DOWNLOADS_DIR="$DATA_DIR/Downloads"
export DOCUMENTS_DIR="$DATA_DIR/Documents"
export IMPORTANT_DIR="$DATA_DIR/Important"
export MUSIC_DIR="$DATA_DIR/Music"
export OTHERS_DIR="$DATA_DIR/Others"
export PICTURES_DIR="$DATA_DIR/Pictures"
export VIDEOS_DIR="$DATA_DIR/Videos"

export GIT_REPOS_DIR="$DOCUMENTS_DIR/git_repos"
export PROGRAMING_DIR="$DOCUMENTS_DIR/programing"

export CONFIGS_DIR="$DOCUMENTS_DIR/configs"
export SCRIPTS_DIR="$CONFIGS_DIR/scripts"
export TEMPLATES_DIR="$CONFIGS_DIR/templates"
export RUN_MODULES_DIR="$SCRIPTS_DIR/run_modules"

# Temporary paths
export AGH_DIR="$DOCUMENTS_DIR/agh"
export CURR_SEM_DIR="$AGH_DIR/semestr_7"
export INZ_DIR="$AGH_DIR/inzynierka"

# Other variables
export JAVA_HOME="$HOME/.jdks/openjdk-17/"
export TERMINAL="xfce4-terminal"
# For non-Fedora environments be sure the PROMPT_COMMAND sets the title bar.                                          
export PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'

# Modify PATH
PATH="$PATH:/opt"
PATH="$PATH:/usr/bin/js"
PATH="$PATH:/usr/share/playonlinux/playonlinux"
PATH="${PATH}:${SCRIPTS_DIR}" # Add scripts directory to PATH
PATH="${PATH}:/opt/MiniZincIDE-2.5.5-bundle-linux-x86_64/bin" # MiniZinc solvers
M2_HOME='/opt/apache-maven-3.6.3'
PATH="$M2_HOME/bin:$PATH"
PATH="$PATH:$HOME/.rvm/bin" # Make sure this is the last PATH variable

# Modify CLASSPATH
export CLASSPATH=".:/usr/local/lib/antlr-4.11.1-complete.jar:$CLASSPATH"

# Modif PYTHONPATH
export PYTHONPATH=${PYTHONPATH}:$GIT_REPOS_DIR/youtube-dl

#-------------------------------------------------------------------------------
# Aliases and functions
#-------------------------------------------------------------------------------

# Aliases definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Functions definitions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi


#-------------------------------------------------------------------------------
# Additions
#-------------------------------------------------------------------------------

# Custom PS1
PS1="$(CPS1 ${BRed})(\t)$(CPS1 ${NC})" # time
PS1=${PS1}"$(CPS1 ${BYellow}) ~ $(CPS1 ${NC})" # separator
PS1=${PS1}"$(CPS1 ${Purple})\u@\h$(CPS1 ${NC})" # username@hostname
PS1=${PS1}"$(CPS1 ${BYellow}) -> $(CPS1 ${NC})" # separator
PS1=${PS1}"$(CPS1 ${BBlue})\w$(CPS1 ${NC})" # current working directory
PS1=${PS1}"$(CPS1 ${NC})\$$(CPS1 ${NC}) " # separator

# Ignore duplicates in command history and increase
# history size to 1000 lines
export HISTCONTROL=ignoredups
export HISTSIZE=1000

# Source thesis files
source "$INZ_DIR/local/env.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/przemek/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/przemek/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/przemek/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/przemek/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
