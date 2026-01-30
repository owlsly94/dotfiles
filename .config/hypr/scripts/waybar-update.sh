#!/bin/bash

MAGENTA='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${MAGENTA}󰚰 Launching Topgrade...${NC}"

topgrade

echo -e "${MAGENTA}󰑐 Refreshing Waybar...${NC}"
pkill -RTMIN+8 waybar

dunstify -u normal -i software-update-available "Topgrade" "System-wide update complete."

echo -e "${GREEN}󰄬 Done!${NC}"
sleep 2
