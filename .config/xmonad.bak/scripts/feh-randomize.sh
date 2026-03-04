#!/bin/bash

# Function to change wallpaper
change_wallpaper() {
    # Get list of all files in the specified folder
    files=("$1"/*)

    # If there are no files in the folder, print an error message
    if [ ${#files[@]} -eq 0 ]; then
        echo "Error: No files found in the specified folder."
        return
    fi

    # Select a random file from the list
    selected_wallpaper="${files[RANDOM % ${#files[@]}]}"

    # Use feh to set the selected file as the wallpaper
    feh --bg-fill "$selected_wallpaper"

    echo "Wallpaper changed to: $selected_wallpaper"
}

# Specify the path to the wallpapers folder
wallpapers_folder="$HOME/.config/wallpapers/"

# Change the wallpaper
change_wallpaper "$wallpapers_folder"
