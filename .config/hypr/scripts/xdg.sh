#!/bin/bash

killall -9 xdg-desktop-portal
sleep 2
killall -9 xdg-desktop-portal-hyprland
sleep 2
systemctl --user stop xdg-desktop-portal
sleep 2
systemctl --user stop xdg-desktop-portal-hyprland
sleep 2
systemctl --user start xdg-desktop-portal-hyprland
sleep 2
systemctl --user start xdg-desktop-portal
