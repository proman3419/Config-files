#!/bin/bash

run_file() {
    if [[ "$interactive" = true ]]; then
        python3 $1 | tee "${RUNTIME_FILES_DIR}/output"
    else
        cat "${RUNTIME_FILES_DIR}/input" | python3 $1 | tee "${RUNTIME_FILES_DIR}/output"
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
