#!/bin/bash

THEME_DIR="$HOME/.config/waybar/themes"
COLOR_CONFIG="$HOME/.config/waybar/colors.css"
MENU_BIN="wofi" # Change to "rofi -dmenu" if you use Rofi

themes=$(ls "$THEME_DIR" | sed 's/\.css//')

choice=$(echo "$themes" | $MENU_BIN --dmenu --prompt "Choose Waybar Theme:")

if [ -z "$choice" ]; then
    exit 1
fi

ln -sf "$THEME_DIR/$choice.css" "$COLOR_CONFIG"

pkill -USR2 waybar

notify-send "Waybar" "Theme changed to $choice"
