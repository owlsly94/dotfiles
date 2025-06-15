#!/bin/bash

systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland

killall -q xdg-desktop-portal-hyprland
killall -q xdg-desktop-portal

/usr/lib/xdg-desktop-portal-hyprland &

sleep 1

/usr/lib/xdg-desktop-portal &

