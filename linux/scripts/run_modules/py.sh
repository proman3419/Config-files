#!/bin/bash

run_file() {
    run_command="python3 $1"

    if [[ "$interactive" = true ]]; then
        echo
        eval $run_command | tee "${RUNTIME_FILES_DIR}/output"
    elif [[ "$to_less" = true ]]; then
        (cat "${RUNTIME_FILES_DIR}/input" | eval $run_command | tee "${RUNTIME_FILES_DIR}/output") | less
    elif [[ "$quiet" = true ]]; then
        (cat "${RUNTIME_FILES_DIR}/input" | eval $run_command) &> "${RUNTIME_FILES_DIR}/output"
        
        if [[ $? -ne 0 ]]; then
            echo
            cat "${RUNTIME_FILES_DIR}/output"
        fi
    else
        echo
        cat "${RUNTIME_FILES_DIR}/input" | eval $run_command | tee "${RUNTIME_FILES_DIR}/output"
    fi

    cp $1 "${RUNTIME_FILES_DIR}/source"
}

run_dir() {
    echo "Directories are not supported for this module"
}

if [[ $file_type -eq 0 ]]; then
    run_file $target_path
elif [[ $file_type -eq 1 ]]; then
    run_dir $target_path
else
    echo "Unsupported file type"
fi
