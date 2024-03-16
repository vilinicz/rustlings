#!/bin/bash

# Empty the file
> exercises/exercises.rs

echo '// This file was auto-generated with ../modularize_exercises.sh script' >> exercises/exercises.rs
# Loop over all .rs files in the exercises directory
for file in $(find ./exercises -type f -name "*.rs"); do
    # Remove the 'exercises/' prefix from the file path
    path=${file#./exercises/}

    # Write the path and module name to the file only if $path variable is present and contains a '/'
    if [[ -n "$path" && "$path" == */* ]]; then
        echo "#[path=\"$path\"]" >> exercises/exercises.rs
    fi

    echo "pub mod $(basename $file .rs);" >> exercises/exercises.rs
done

echo 'Done'