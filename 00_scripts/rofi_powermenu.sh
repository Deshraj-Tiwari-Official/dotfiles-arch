#!/bin/bash

# State Tracking & Cleanup
echo "$HOME/dotfiles/00_scripts/rofi_powermenu.sh" > /tmp/active_rofi_menu
trap 'rm -f /tmp/active_rofi_menu' EXIT

# Menu Options Definition (Icons only)
shutdown="󰐥"
reboot=""
suspend="󰤄"
logout="󰍃"

# Rofi GUI Prompt & Custom Inline Theme
selected=$(printf "%s\n%s\n%s\n%s" \
    "$shutdown" "$reboot" "$suspend" "$logout" | \
    rofi -dmenu \
         -p "Power" \
         -theme-str '
            @import "~/.cache/wal/colors-rofi-dark.rasi"

            * {
                font: "JetBrainsMono Nerd Font 36";
                background-color: transparent;
                text-color: @foreground;
            }

            window {
                width: 320px;
                background-color: @background;
                border-radius: 36px;
                border: 2px;
                border-color: @color8;
                padding: 24px;
            }

            mainbox {
                background-color: transparent;
                children: [ listview ];
            }

            inputbar {
                enabled: false;
            }

            listview {
                columns: 2;
                lines: 2;
                spacing: 16px;
                cycle: true;
                dynamic: false;
                scrollbar: false;
                flow: horizontal;
            }

            element {
                background-color: @background-alt;
                border-radius: 35px;
                padding: 28px 0px;
                cursor: pointer;
            }

            element selected {
                background-color: @color8;
                text-color: @color4;
            }

            element-text {
                horizontal-align: 0.5;
                vertical-align: 0.5;
                text-color: inherit;
                cursor: inherit;
            }

            element-icon {
                enabled: false;
            }
         ')

# Action Dispatcher
case "$selected" in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
esac
