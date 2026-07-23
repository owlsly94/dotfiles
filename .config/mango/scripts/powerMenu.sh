#!/bin/bash

chosen=$(printf "Power Off\nRestart" | wofi -dmenu -i -theme-str 'power.rasi')

case "$chosen" in
  "Power off") poweroff ;;
  "Restart") reboot ;;
  *) exit 1 ;;
esac
