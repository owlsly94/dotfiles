#!/bin/bash

# Function to display a confirmation prompt
confirm_update() {
    echo -n "Do you want to proceed with the update? (y/n): "
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY])
            echo "Proceeding with the update using yay..."
            ;;
        [nN][oO]|[nN])
            echo "Update canceled."
            exit 1
            ;;
        *)
            echo "Invalid input. Please enter 'y' for yes or 'n' for no."
            confirm_update
            ;;
    esac
}

# Prompt the user for confirmation
confirm_update

# Update and upgrade system packages
echo "Updating system packages..."
sudo pacman -Syu --noconfirm

# Check for any orphaned packages and remove them
echo "Removing orphaned packages..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm

# Update AUR packages
echo "Updating AUR packages..."
yay -Syu --noconfirm

# Clean up Yay cache
echo "Cleaning up Yay cache..."
yay -Sc --noconfirm

echo "System update complete!"
sleep 3

