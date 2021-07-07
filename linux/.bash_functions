# Set gnome-terminal title
set-title() {
    ORIG=$PS1
    TITLE="\e]2;$@\a"
    PS1=${ORIG}${TITLE}
}

# Copy templates
ct() {
    declare -A name_to_filename

    # Add/remove if needed
    name_to_filename["c"]="c.c"
    name_to_filename["cppcp"]="cp.cpp"
    name_to_filename["cpp"]="cpp.cpp"
    name_to_filename["py"]="py.py"

    extension="$(cut -d '.' -f2 <<< ${name_to_filename[$1]})"

    cp "${TEMPLATES_DIR}/${name_to_filename[$1]}" "${2}.${extension}"
}
