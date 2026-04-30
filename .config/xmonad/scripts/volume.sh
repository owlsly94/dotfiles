#!/bin/bash

audio() {
    vol="$(pamixer --get-volume)"
    check_output=$(pacmd list-sinks | awk '/* index:/{print $3}')

    if [ $check_output == 1 ]; then
        echo "  $vol"
    else
        echo "󰓃 $vol"
    fi
}

echo "$(audio)%"
