#!/bin/bash

# Define the path to your local repository
REPO_PATH="/home/reuben/Documents/Obsidian/"

# Navigate to the repository
cd "$REPO_PATH"

# Get current timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")

# Add all changes
git add .

# Commit changes with the timestamp
git commit -m "Auto Commit on $TIMESTAMP"

# Push the changes
git push

