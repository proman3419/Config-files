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

declare -A name_to_relative_path
declare -A name_to_description

name_to_relative_path["c"]="c.sh"
name_to_relative_path["cpp"]="cpp.sh"
name_to_relative_path["py"]="py.sh"
name_to_relative_path["hs"]="hs.sh"

name_to_description["c"]="Standard C"
name_to_description["cpp"]="Standard C++"
name_to_description["py"]="Standard Python"
name_to_description["hs"]="Standard Haskell"

record_time=false
interactive=false
to_less=false
quiet=false
file_type=-1


#-------------------------------------------------------------------------------
# Logic
#-------------------------------------------------------------------------------

print_help() {
    echo "Usage: run.sh [MODULE_NAME] [PATH]"
    echo "Takes file(s) from PATH, and executes using the module MODULE_NAME."
    echo

    echo "Additional flags"
    printf '  %-17s %s\n' "-t" "record execution time"
    printf '  %-17s %s\n' "-i" "read input from keyboard (interactive mode)"
    printf '  %-17s %s\n' "-l" "redirect output to less (less mode)"
    printf '  %-17s %s\n' "-q" "don't display output unless an error occured (quiet mode)"
    echo

    echo "By default the script uses the following files:"
    echo "- ${RUNTIME_FILES_DIR}/input - read input,"
    echo "- ${RUNTIME_FILES_DIR}/output - redirect output (always),"
    echo "- ${RUNTIME_FILES_DIR}/source - copy source code (always),"
    echo "- ${RUNTIME_FILES_DIR}/compiled - compiled executable (always)."
    echo

    echo "Modules are kind of scripts that specify language and additional parameters."
    echo "All modules are located in ${RUN_MODULES_DIR}."
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
        exit 0
    fi

    if [[ $# -lt $mandatory_args_cnt ]]; then
        echo "Missing argument(s)"
        exit 1
    fi

    for ((i=$mandatory_args_cnt+1; i <= $#; i++)); do
        case ${!i} in
        "-t")
            record_time=true
            ;;
        "-i")
            interactive=true
            ;;
        "-l")
            to_less=true
            if [[ "$interactive" = true ]]; then
                echo "Choose either -i, -l or -q flag"
                exit 1
            fi
            ;;
        "-q")
            quiet=true
            if [[ "$interactive" = true || "$to_less" = true ]]; then
                echo "Choose either -i, -l or -q flag"
                exit 1
            fi
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

print_mode() {
    printf "Using the "
    if [[ "$interactive" = true ]]; then
        printf "interactive "
    elif [[ $to_less = true ]]; then
        printf "less "
    elif [[ $quiet = true ]]; then
        printf "quiet "
    else
        printf "default "
    fi
    echo "mode"
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
            print_mode

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
