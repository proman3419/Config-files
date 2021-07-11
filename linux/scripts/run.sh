#!/bin/bash

#-------------------------------------------------------------------------------
# Data
#-------------------------------------------------------------------------------

# Parameters:
# $1 - module's name or --help
# $2 - path to a file or a directory
# $3+ - additional flags
mandatory_args_cnt=2
module_name=$1
target_path=$2

# Environment variables:
# RUN_MODULES_DIR
# RUNTIME_FILES_DIR

interactive=false
record_time=false
file_type=-1

declare -A name_to_relative_path
declare -A name_to_description

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
    echo

    echo "Modules are kind of scripts that specify language and additional parameters."
    echo 
    
    echo "Input is read from ${RUNTIME_FILES_DIR}/input by default."
    echo "In order to read input from keyboard add 'i' at the end of a module's name."
    echo

    echo "All modules are located in ${RUN_MODULES_DIR}"
    echo

    printf '%-20s' "MODULE_NAME" "RELATIVE_PATH" "DESCRIPTION"
    echo
    for e in "${!name_to_relative_path[@]}"; do
        printf '%-20s' "${e}" "${name_to_relative_path[$e]}"  "${name_to_description[$e]}"
        echo
    done
}

read_flags() {
    if [[ $1 == "--help" ]]; then
        print_help
    fi

    for ((i=$mandatory_args_cnt+1; i <= $#; i++)); do
        case ${!i} in
        "-i")
            interactive=true
            ;;
        "-t")
            record_time=true
            echo $record_time
            ;;
        *)
            ;;
        esac
    done
}

check_file_type() {
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

read_flags "$@"

if [[ -z ${name_to_relative_path[$1]} ]]; then
    echo "No such module"
elif [[ !(-e "${RUN_MODULES_DIR}/${name_to_relative_path[$1]}") ]]; then
    echo "Missing module file(s)"
else
    module_full_path="${RUN_MODULES_DIR}/${name_to_relative_path[$1]}"
    check_file_type $target_path

    if [[ $file_type -ne -1 ]]; then
        if [[ -x $module_full_path ]]; then
            echo "Running the module '${module_name}' on '${target_path}'"
            echo

            if [[ "$record_time" = true ]]; then
                time source $module_full_path
            else
                source $module_full_path
            fi
        else
            echo "The module doesn't have executable permissions"
        fi
    fi
fi
