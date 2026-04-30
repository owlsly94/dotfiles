#!/bin/bash

# Set the directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/.config/wallpapers"

# Use Rofi to display a list of wallpapers in the specified directory
selected_wallpaper=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Choose wallpaper:")

# Check if a wallpaper was selected
if [ -n "$selected_wallpaper" ]; then
    # Set the full path to the selected wallpaper
    wallpaper_path="$WALLPAPER_DIR/$selected_wallpaper"
    
    # Set the wallpaper using feh
    feh --bg-fill "$wallpaper_path"
    
    # Display a notification about the wallpaper change using dunstify
    dunstify -a "Wallpaper" "Changed wallpaper to $selected_wallpaper" 
fi

