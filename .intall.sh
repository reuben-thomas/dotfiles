#!/bin/bash

# Template Bash Script to Copy Files

# Define target directories
TARGET_DIR1="/path/to/target_directory1"
TARGET_DIR2="/path/to/target_directory2"
# Add more target directories as needed

# Loop over each file in the current directory
for file in *; do
    # Check if it's a file and not a directory
    if [ -f "$file" ]; then
        # Copy file to each target directory
        cp "$file" "$TARGET_DIR1"
        cp "$file" "$TARGET_DIR2"
        # Add more copy commands for additional target directories
    fi
done

echo "Files copied successfully."

