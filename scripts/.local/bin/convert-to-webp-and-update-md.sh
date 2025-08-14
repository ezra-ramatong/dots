#!/usr/bin/env bash

# Base directory to start the search (use current directory by default)
BASE_DIR=${1:-.}

# Quality setting for WebP conversion (adjust as needed)
QUALITY=${2:-85}

# Counter for tracking conversions
converted_count=0
skipped_count=0
updated_files=0

echo "Starting WebP conversion in $BASE_DIR..."

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

# Summary of conversion
if [[ $converted_count -eq 0 && $skipped_count -eq 0 ]]; then
    echo "No images found to convert in $BASE_DIR"
elif [[ $converted_count -eq 0 ]]; then
    echo "No new conversions needed - all $skipped_count images already have WebP versions"
else
    echo "Conversion complete! Converted: $converted_count, Skipped: $skipped_count"
fi

echo ""
echo "Updating markdown references..."

# Find all index.md files recursively and update their references
find "$BASE_DIR" -name "index.md" | while read -r md_file; do
    dir=$(dirname "$md_file")
    file_updated=false
    
    # Find all .webp files in the same directory
    find "$dir" -maxdepth 1 -name "*.webp" | while read -r webp_file; do
        webp_basename=$(basename "$webp_file" .webp)
        
        # Check if any of these references exist in the markdown file
        if grep -q "${webp_basename}\.\(jpg\|jpeg\|png\)" "$md_file"; then
            # Update references from .jpg, .jpeg, .png to .webp for this specific file
            sed -i.bak \
                -e "s/${webp_basename}\.jpg/${webp_basename}.webp/g" \
                -e "s/${webp_basename}\.jpeg/${webp_basename}.webp/g" \
                -e "s/${webp_basename}\.png/${webp_basename}.webp/g" \
                "$md_file"
            
            if [[ ! $file_updated ]]; then
                echo "Updated references in $md_file"
                ((updated_files++))
                file_updated=true
            fi
        fi
    done
done

echo "Markdown update complete! Updated $updated_files files"
echo ""
echo "All done! Your images are now WebP format and markdown references have been updated."
