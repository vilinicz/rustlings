#!/bin/bash

# Empty the file
> exercises/exercises.rs
echo "// this file was auto-generated with modularize_exercises.sh script" >> exercises/exercises.rs

# Loop over all .rs files in the subdirectories of the exercises directory
for dir in ./exercises/*; do
    if [ -d "$dir" ]; then
        for file in $(find $dir -type f -name "*.rs"); do
            # Remove the './exercises/' prefix from the file path
            path=${file#./exercises/}

            # Write the path and module name to the file
            echo "#[path=\"$path\"]" >> exercises/exercises.rs
            echo "pub mod $(basename $file .rs);" >> exercises/exercises.rs
        done
    fi
done

echo 'Done'