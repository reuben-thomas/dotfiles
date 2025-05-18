#!/bin/bash

# Define the directory containing the .MTS files
DIRECTORY="$HOME/Downloads"

# Navigate to the directory
cd "$DIRECTORY"

# Loop through all .MTS files in the directory
for file in *.MTS; do
  # Generate the output file name by replacing the .MTS extension with .mp4
  output="${file%.MTS}.mp4"

  # Run the ffmpeg command to convert the file
  ffmpeg -i "$file" -c:v copy -c:a aac -strict experimental -b:a 128k "$output"
done
