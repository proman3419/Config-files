# Set gnome-terminal title
set-title() {
    ORIG=$PS1
    TITLE="\e]2;$@\a"
    PS1=${ORIG}${TITLE}
}

wifi_connect() {
    read -p "network name: " network_name
    read -p "password: " -s password
    echo
    nmcli dev wifi connect $network_name password $password
}

wifi_show() {
    nmcli dev wifi
}
