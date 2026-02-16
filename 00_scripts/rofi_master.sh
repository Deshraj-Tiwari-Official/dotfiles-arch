#!/bin/bash

options="󰀻  Apps\n⏻  Power"

chosen=$(echo -e "$options" | rofi -dmenu -p "Run" -theme-str 'window { width: 250px; } listview { lines: 3; } inputbar { enabled: false; } element-icon {enabled: false;}')

case "$chosen" in
    *Apps)  rofi -show drun ;;
    *Power) ~/dotfiles/00_scripts/rofi_powermenu.sh;;
esac
