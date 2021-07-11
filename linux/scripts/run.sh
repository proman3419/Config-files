#!/bin/bash

#-------------------------------------------------------------------------------
# Variables
#-------------------------------------------------------------------------------

# Environment variables:
# RUN_MODULES_DIR
# RUNTIME_FILES_DIR

declare -A name_to_relative_path
declare -A name_to_description

# Add/remove if needed
name_to_relative_path["c"]="c.sh"
name_to_relative_path["cpp"]="cpp.sh"
name_to_relative_path["py"]="py.sh"

name_to_description["c"]="Standard C"
name_to_description["cpp"]="Standard C++"
name_to_description["py"]="Standard Python"


#-------------------------------------------------------------------------------
# Logic
#-------------------------------------------------------------------------------

print_help() {
    echo "Usage: run [MODULE_NAME] [PATH]"
    echo "Takes file(s) from PATH, and executes using the module MODULE_NAME."
    echo "Modules are kind of scripts that specify language and additional parameters."
    echo "All modules are located in ${RUN_MODULES_DIR}"
    echo

    printf '%-20s' "MODULE_NAME" "RELATIVE_PATH" "DESCRIPTION"
    echo
    for e in "${!name_to_relative_path[@]}"; do
        printf '%-20s' "${e}" "${name_to_relative_path[$e]}"  "${name_to_description[$e]}"
        echo
    done
}

check_file_type() {
    file_type=-1

    if [[ -f $1 ]]; then
        file_type=0
    elif [[ -d $1 ]]; then
        file_type=1
    elif [[ !(-e $1) ]]; then
        echo "The passed path is empty"
    else
        echo "Unsupported file type"
    fi
}

# $1 - module's name or --help
# $2 - path to a file or a directory
if [[ $1 == "--help" ]]; then
    print_help
elif [[ $# -ne 2 ]]; then
    echo "Illegal number of parameters"
elif [[ -z ${name_to_relative_path[$1]} ]]; then
    echo "No such module"
elif [[ !(-e "${RUN_MODULES_DIR}/${name_to_relative_path[$1]}") ]]; then
    echo "Missing module file(s)"
else
    module_full_path="${RUN_MODULES_DIR}/${name_to_relative_path[$1]}"
    check_file_type $2

    if [[ $file_type -ne -1 ]]; then
        if [[ -x $module_full_path ]]; then
            echo "Running the module '${1}' on '${2}'"
            echo
            time /bin/bash $module_full_path $2 $file_type
        else
            echo "The module doesn't have executable permissions"
        fi
    fi
fi
