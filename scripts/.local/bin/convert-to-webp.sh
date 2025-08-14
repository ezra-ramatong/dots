#!/usr/bin/env bash

# Base directory to start the search (use current directory by default)
BASE_DIR=${1:-.}

# Quality setting for WebP conversion (adjust as needed)
QUALITY=${2:-85}

# Counter for tracking conversions
converted_count=0
skipped_count=0

# Find all image files (jpg, jpeg, png) recursively and loop over them
find "$BASE_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r file; do
    # Get the directory and filename without extension
    dir=$(dirname "$file")
    filename=$(basename "$file")
    name_without_ext="${filename%.*}"
    
    # Define the output WebP file path
    webp_file="$dir/$name_without_ext.webp"
    
    # Skip if WebP version already exists
    if [[ -f "$webp_file" ]]; then
        echo "Skipping $file - WebP version already exists"
        ((skipped_count++))
        continue
    fi
    
    # Convert to WebP
    if magick "$file" -quality "$QUALITY" "$webp_file"; then
        echo "Converted $file to $webp_file"
        ((converted_count++))
        
        # Optional: Remove original file (uncomment next line if you want this)
        # rm "$file"
    else
        echo "Failed to convert $file"
    fi
done

# Summary
if [[ $converted_count -eq 0 && $skipped_count -eq 0 ]]; then
    echo "No images found to convert in $BASE_DIR"
elif [[ $converted_count -eq 0 ]]; then
    echo "No new conversions needed - all $skipped_count images already have WebP versions"
else
    echo "Conversion complete! Converted: $converted_count, Skipped: $skipped_count"
fi
