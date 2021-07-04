# Set gnome-terminal title
set-title() {
    ORIG=$PS1
    TITLE="\e]2;$@\a"
    PS1=${ORIG}${TITLE}
}

# Copy templates
ct() {
    cp ${TEMPLATES_DIR}/c.c $1
}

cpt() {
    cp ${TEMPLATES_DIR}/cp.cpp $1
}

cppt() {
    cp ${TEMPLATES_DIR}/cpp.cpp $1   
}

pt() {
    cp ${TEMPLATES_DIR}/p.py $1
}
