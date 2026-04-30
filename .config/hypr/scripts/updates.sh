#!/bin/bash

updates() {
    if ! pacman_updates=$(checkupdates 2>/dev/null | wc -l); then
        pacman_updates=0
    fi

    if ! aur_updates=$(yay -Qum 2>/dev/null | wc -l); then
        aur_updates=0
    fi

    total=$((pacman_updates + aur_updates))

    echo "$total"
}

updates
