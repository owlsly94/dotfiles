#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers/"

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Folder $WALLPAPER_DIR does not exist!"
    exit 1
fi

RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

swww img "$RANDOM_WALLPAPER" \
    --transition-type grow \
    --transition-duration 2 \
    --transition-fps 60

echo "Background changed to: $RANDOM_WALLPAPER"
