#!/bin/bash

WALL_DIR="$HOME/.config/wallpapers"

list_wallpapers() {
    for file in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
        echo -en "$(basename "$file")\0icon\x1f$file\n"
    done
}

choice=$(list_wallpapers | rofi -dmenu \
  -theme ~/.config/hypr/scripts/wall-selector/wall-style.rasi \
  -p "Select Wallpaper" \
  -mesg "Use arrow keys (← →) to navigate; Enter to apply")

if [ -n "$choice" ]; then
    swww img "$WALL_DIR/$choice" --transition-type center --transition-fps 60
fi
