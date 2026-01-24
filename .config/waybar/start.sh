#!/bin/bash

if [ -f "$HOME/.cache/waybar-disabled" ]; then 
    pkill waybar
    exit 1 
fi

pkill waybar

while pgrep -u $USER -x waybar >/dev/null; do 
    sleep 0.5
done

waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css &
