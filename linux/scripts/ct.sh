#!/bin/bash

#-------------------------------------------------------------------------------
# Variables
#-------------------------------------------------------------------------------

declare -A name_to_filename
declare -A name_to_description

# Add/remove if needed
name_to_filename["c"]="c.c"
name_to_filename["cpp"]="cpp.cpp"
name_to_filename["cppcp"]="cp.cpp"
name_to_filename["py"]="py.py"

name_to_description["c"]="Standard C"
name_to_description["cpp"]="Standard C++"
name_to_description["cppcp"]="Competitive programming C++"
name_to_description["py"]="Standard Python"


#-------------------------------------------------------------------------------
# Logic
#-------------------------------------------------------------------------------

print_help() {
    echo "Usage: ct [NAME] [FILE_PATH]"
    echo "Creates a copy of template NAME in FILE_PATH, don't specify the extension in FILE_PATH."
    echo "All templates are located in ${TEMPLATES_DIR}."
    echo

    printf '%-20s' "NAME" "FILENAME" "DESCRIPTION"
    echo
    for i in "${!name_to_filename[@]}"; do
        printf '%-20s' "${i}" "${name_to_filename[$i]}"  "${name_to_description[$i]}"
        echo
    done
}

if [[ "--help" == "$1" ]]; then
    print_help
elif [[ "$#" -ne 2 ]]; then
    echo "Illegal number of parameters"
elif [[ -z ${name_to_filename[$1]} ]]; then
    echo "No such template"
else
    extension="$(cut -d '.' -f2 <<< ${name_to_filename[$1]})"
    file_path="${2}.${extension}"
    cp "${TEMPLATES_DIR}/${name_to_filename[$1]}" "${file_path}"

    if [[ -f "${file_path}" ]]; then
        echo "Created a copy of $1 in $file_path"
    fi
fi
