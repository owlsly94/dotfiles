#!/bin/bash

# Check for updates and count them
updates=$(yay -Qu | wc -l)

# Output the number of updates in JSON format
echo "$updates"

