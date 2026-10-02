#!/bin/bash

WALL=$(find "$HOME/dotfiles/backgrounds" -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    | shuf -n 1)

sed "s|^\\\$wall =.*|\$wall = $WALL|" \
    "$HOME/dotfiles/hypr/hyprlock.conf" > /tmp/hyprlock.conf

hyprlock -c /tmp/hyprlock.conf
