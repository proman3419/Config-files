# Set gnome-terminal title
set-title() {
    ORIG=$PS1
    TITLE="\e]2;$@\a"
    PS1=${ORIG}${TITLE}
}

wifi_connect() {
    nmcli dev wifi connect $1 password $2
}
