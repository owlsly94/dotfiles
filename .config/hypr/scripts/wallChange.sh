#!/bin/bash

change_wallpaper() {
  files=("$1"/*)

  if [ ${#files[@]} -eq 0 ]; then
    echo "Error: Can't find the folder!"
    return
  fi

  selected_wallpaper="${files[RANDOM % ${#files[@]}]}"
  swww img "$selected_wallpaper" \
    --transition-type="wipe" \
    --transition-duration=0.7

  echo "Wallpaper changed to: $selected_wallpaper"
}

wallpapers_folder="$HOME/.config/wallpapers/"

change_wallpaper "$wallpapers_folder"
