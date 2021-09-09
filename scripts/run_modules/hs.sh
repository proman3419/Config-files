#!/bin/bash

run() {
    compilation_failed=false
    (ghc -o "${RUNTIME_FILES_DIR}/compiled" $1) &> /dev/null

    if [[ $? -ne 0 ]]; then
        echo
        ghc -o "${RUNTIME_FILES_DIR}/compiled" $1
        compilation_failed=true
    elif [[ -n $output ]]; then
        echo
        echo $output
    fi

    run_command="${RUNTIME_FILES_DIR}/compiled"

    if [[ "$compilation_failed" = false ]]; then
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
    fi
}

if [[ $file_type -eq 0 ]]; then
    run $target_path
elif [[ $file_type -eq 1 ]]; then
    echo "TODO: directories support"
else
    echo "Unsupported file type"
fi
