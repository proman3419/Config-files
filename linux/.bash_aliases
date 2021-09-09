# General
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias vi='vim'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias gput='nvidia-smi -q -d temperature'
alias setclip='xclip -selection c'
alias getclip='xclip -selection c -o'

# Games
#alias soldat='/usr/share/playonlinux/playonlinux --run "Soldat" %F'
alias soldat='wine ~/.PlayOnLinux/wineprefix/Soldat/drive_c/Soldat/starter.exe'
alias arsse='wine /opt/ARSSE/ARSSE.exe'

# Programing
alias idea='/opt/idea-IC-192.7142.36/bin/idea.sh'
alias python3m='python3 -m cProfile'
alias python='python3'
alias haskell='ghc'

# Hacking
alias kali='virtualbox --fullscreen -startvm "Kali"'
alias stegsolve='/opt/stegsolve/Stegsolve.jar'

# Others
alias winbox='wine /opt/winbox/winbox64.exe'
