#!/bin/bash

# Run the sensors command and capture its output
SENSOR_OUTPUT=$(sensors k10temp-pci-00c3)

# Use grep to find the line containing 'Tctl' and awk to extract the temperature, then strip non-numeric characters
TCTL_TEMP=$(echo "$SENSOR_OUTPUT" | grep 'Tctl' | awk '{print $2}' | sed 's/+//;s/°C//')

# Print only the temperature number
echo " $TCTL_TEMP°C"

