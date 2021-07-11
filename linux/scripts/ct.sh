#!/bin/bash

#-------------------------------------------------------------------------------
# Variables
#-------------------------------------------------------------------------------

# Environment variables:
# TEMPLATES_DIR

declare -A name_to_relative_path
declare -A name_to_description

# Add/remove if needed
name_to_relative_path["c"]="c.c"
name_to_relative_path["cpp"]="cpp.cpp"
name_to_relative_path["cppcp"]="cp.cpp"
name_to_relative_path["py"]="py.py"
name_to_relative_path["dir"]="dir"

name_to_description["c"]="Standard C"
name_to_description["cpp"]="Standard C++"
name_to_description["cppcp"]="Competitive programming C++"
name_to_description["py"]="Standard Python"
name_to_description["dir"]="Testing directories"


#-------------------------------------------------------------------------------
# Logic
#-------------------------------------------------------------------------------

print_help() {
    echo "Usage: ct [TEMPLATE_NAME] [PATH]"
    echo "Creates a copy of template TEMPLATE_NAME in PATH, don't specify the extension in PATH."
    echo "All templates are located in ${TEMPLATES_DIR}."
    echo

    printf '%-20s' "TEMPLATE_NAME" "RELATIVE_PATH" "DESCRIPTION"
    echo
    for e in "${!name_to_relative_path[@]}"; do
        printf '%-20s' "${e}" "${name_to_relative_path[$e]}"  "${name_to_description[$e]}"
        echo
    done
}

# $1 - template's name or --help
# $2 - path to a file or a directory
if [[ $1 == "--help" ]]; then
    print_help
elif [[ $# -ne 2 ]]; then
    echo "Illegal number of parameters"
elif [[ -z ${name_to_relative_path[$1]} ]]; then
    echo "No such template"
elif [[ !(-e "${TEMPLATES_DIR}/${name_to_relative_path[$1]}") ]]; then
    echo "Missing template file(s)"
else
    extension="$(cut -d '.' -f2 <<< ${name_to_relative_path[$1]})"

    if [[ ${name_to_relative_path[$1]} == $extension ]]; then
        path=$2
    else
        path=${2}.${extension}
    fi

    cp -r "${TEMPLATES_DIR}/${name_to_relative_path[$1]}" "$path"

    if [[ -e $path ]]; then
        echo "Created a copy of '${1}' in '${path}'"
    fi
fi
