#!/bin/bash

# Configuration
WALLPAPER_DIR="$HOME/.config/wallpapers"
TMP_FILE="/tmp/selected_wallpaper"

# Open ranger in "choosefile" mode. 
# It will exit and write the path of your choice to the TMP_FILE.
ranger --choosefile="$TMP_FILE" "$WALLPAPER_DIR"

# Check if a file was actually chosen
if [ -f "$TMP_FILE" ]; then
    SELECTED_WALL=$(cat "$TMP_FILE")
    
    # Apply with swww
    swww img "$SELECTED_WALL" --transition-type outer --transition-fps 60
    
    # Cleanup
    rm "$TMP_FILE"
    notify-send "Wallpaper Set" "$(basename "$SELECTED_WALL")"
fi
