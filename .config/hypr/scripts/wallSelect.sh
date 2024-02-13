#!/bin/bash

WALLPAPERS_DIR="$HOME/.config/wallpapers/"

selected_wallpaper=$(ls "$WALLPAPERS_DIR" | wofi -dmenu -p "Choose wallpaper:")

if [ -n "$selected_wallpaper" ]; then
  wallpaper_path="$WALLPAPERS_DIR/$selected_wallpaper"

  swww img "$wallpaper_path"
fi 
