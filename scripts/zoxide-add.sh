#!/bin/bash

# Initialize a counter for the total number of directories added
total_added=0

# Iterate over every item in the current directory
for file in *; do
	# Check if the item is a directory
	if [ -d "$file" ]; then
		# Execute zoxide add command on the directory
		zoxide add "$PWD/$file"
		# Increment the counter
		((total_added++))
	fi
done

# Display the total number of directories added
echo "$total_added directories added."
