#!/bin/bash

CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${MAGENTA}󰛭 Starting System Upgrade...${NC}"

echo -e "${CYAN}󰃢 Cleaning system package cache (keeping 3 versions)...${NC}"
sudo paccache -r

echo -n "Do you want to proceed with yay? (y/n): "
read -r response
if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${RED}Update canceled.${NC}"
    exit 1
fi

echo -e "${CYAN}󰇚 Syncing repositories and upgrading...${NC}"
yay -Syu

ORPHANS=$(pacman -Qdtq)
if [ -n "$ORPHANS" ]; then
    echo -e "${CYAN}󱂵 Removing orphaned packages...${NC}"
    sudo pacman -Rns $ORPHANS --noconfirm
else
    echo -e "${GREEN}󰄬 No orphaned packages to remove.${NC}"
fi

echo -e "${CYAN}󰃢 Cleaning yay cache...${NC}"
yay -Sc --noconfirm

echo -e "${MAGENTA}󰑐 Refreshing Waybar...${NC}"
pkill -RTMIN+8 waybar

dunstify -u normal -i software-update-available "System Update" "All packages have been updated successfully."

echo -e "${GREEN}󰄬 System update complete!${NC}"
sleep 2
