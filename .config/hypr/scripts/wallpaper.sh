#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers/"

if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper Error" "Folder $WALLPAPER_DIR does not exist!"
    exit 1
fi

RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" -o -name "*.jpeg" \) | shuf -n 1)

if [ -n "$RANDOM_WALLPAPER" ]; then
    swww img "$RANDOM_WALLPAPER" \
        --transition-type grow \
        --transition-duration 2 \
        --transition-fps 60 \
        --transition-pos top-right # Makes the 'grow' start from the corner

    notify-send "Wallpaper Changed" "Now viewing: $(basename "$RANDOM_WALLPAPER")"
else
    notify-send "Wallpaper Error" "No images found in $WALLPAPER_DIR"
fi
