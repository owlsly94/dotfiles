#!/bin/bash
updates() {
    if ! dnf_updates=$(dnf check-update --refresh -q 2>/dev/null | grep -c '^[a-zA-Z0-9]'); then
        dnf_updates=0
    fi
    if ! flatpak_updates=$(flatpak remote-ls --updates 2>/dev/null | wc -l); then
        flatpak_updates=0
    fi
    total=$((dnf_updates + flatpak_updates))
    echo "$total"
}
updates
