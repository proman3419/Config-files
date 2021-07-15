#!/bin/bash

#-------------------------------------------------------------------------------
# Data
#-------------------------------------------------------------------------------

# Parameters:
# $1 - template's name or --help
# $2 - path to a file or a directory
template_name=$1
target_path=$2

# Environment variables:
# TEMPLATES_DIR

declare -A name_to_relative_path
declare -A name_to_description

name_to_relative_path["c"]="c.c"
name_to_relative_path["cpp"]="cpp.cpp"
name_to_relative_path["cppcp"]="cp.cpp"
name_to_relative_path["py"]="py.py"
name_to_relative_path["sh"]="sh.sh"

name_to_description["c"]="Standard C"
name_to_description["cpp"]="Standard C++"
name_to_description["cppcp"]="Competitive programming C++"
name_to_description["py"]="Standard Python"
name_to_description["sh"]="Standard Bash"

template_relative_path=${name_to_relative_path[$template_name]}


#-------------------------------------------------------------------------------
# Logic
#-------------------------------------------------------------------------------

print_help() {
    echo "Usage: ct [TEMPLATE_NAME] [PATH]"
    echo "Creates a copy of template TEMPLATE_NAME in PATH, don't specify the extension in PATH."
    echo

    echo "All templates are located in ${TEMPLATES_DIR}."
    echo

    printf '%-20s' "TEMPLATE_NAME" "RELATIVE_PATH" "DESCRIPTION"
    echo
    for e in "${!name_to_relative_path[@]}"; do
        printf '%-20s' "${e}" "${name_to_relative_path[$e]}"  "${name_to_description[$e]}"
        echo
    done
}

read_flags() {
    if [[ $1 == "--help" ]]; then
        print_help
        exit 0
    fi
}

read_flags "$@"

if [[ $# -ne 2 ]]; then
    echo "Illegal number of parameters"
elif [[ -z $template_relative_path ]]; then
    echo "No such template"
elif [[ !(-e "${TEMPLATES_DIR}/${template_relative_path}") ]]; then
    echo "Missing template file(s)"
else
    template_full_path="${TEMPLATES_DIR}/${template_relative_path}"
    extension="$(cut -d '.' -f2 <<< $template_relative_path)"

    if [[ $template_relative_path != $extension ]]; then
        target_path="${target_path}.${extension}"
    fi

    cp -r "$template_full_path" "$target_path"

    if [[ -e $target_path ]]; then
        echo "Created a copy of '${template_name}' in '${target_path}'"
    fi
fi
