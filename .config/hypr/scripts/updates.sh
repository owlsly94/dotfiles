#!/bin/bash

updates() {
    if ! pacman_updates=$(checkupdates 2> /dev/null | wc -l ); then
        pacman_updates=0
    fi

    if ! aur_updates=$(paru -Qum 2> /dev/null | wc -l ); then
        aur_updates=0
    fi

    available=$(("$pacman_updates" + "$aur_updates"))

    if [ $available == 0 ]; then 
        echo "0"
    else
        echo "$available"
    fi
}

echo "$(updates)"
