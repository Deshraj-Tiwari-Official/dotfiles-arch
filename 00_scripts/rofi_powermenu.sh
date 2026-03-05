#!/bin/bash

# Nerd Font icons (fallback text included)
shutdown="⏻  Shutdown"
reboot="  Reboot"
suspend="󰤄  Suspend"
logout="󰍃  Logout"

selected=$(printf "%s\n%s\n%s\n%s" \
    "$shutdown" "$reboot" "$suspend" "$logout" | \
    rofi -dmenu \
         -p "Power" \
         -theme-str '
            * {
                font: "JetBrainsMono Nerd Font 12";
            }

            window {
                width: 240px;
            }

            inputbar {
                enabled: false;
            }

            listview {
                spacing: 8px;
                cycle: false;
                dynamic: false;
            }

            element {
                border: 1px;
                padding: 20px 0px;
                background-color: #11141b;
                text-color: #ffffff;
                cursor: pointer;
            }

            element-icon {
                enabled: false;
            }

            element-text {
                horizontal-align: 0.5;
                vertical-align: 0.5;
                cursor: inherit;
            }

            element selected {
                background-color: #1a1f2b;
                border: 2px;
            }
         ')

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
