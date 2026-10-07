#!/bin/bash

# Start waybar (no need to wait unless you're doing layout logic after)
waybar &

# Wait for waybar to start
sleep 0.225

# Restore the settings
hyprctl eval 'hl.config({ general = { border_size = 1 } })'
hyprctl eval 'hl.config({ general = { gaps_in = 3 } })'
hyprctl eval 'hl.config({ general = { gaps_out = 9 } })'
hyprctl eval 'hl.config({ decoration = { rounding = 10 } })'
