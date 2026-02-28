#!/bin/bash
systemctl --user stop xdg-desktop-portal
systemctl --user stop xdg-desktop-portal-hyprland
systemctl --user stop xdg-desktop-portal-gtk
sleep 1
systemctl --user start xdg-desktop-portal-hyprland
systemctl --user start xdg-desktop-portal-gtk
sleep 2
systemctl --user start xdg-desktop-portal
