#!/usr/bin/env bash

# Base directory to start the search (use current directory by default)
BASE_DIR=${1:-.}

# Find all '_index.md' files recursively and loop over them
find "$BASE_DIR" -type f -name '_index.md' | while read -r file; do
    # Get the directory path of the '_index.md'
    dir=$(dirname "$file")
    
    # Rename '_index.md' to 'index.md'
    mv "$file" "$dir/index.md"
    
    echo "Renamed $file to $dir/index.md"
done

