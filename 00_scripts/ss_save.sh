#!/bin/bash

# Generate Timestamp & Target File Path
timestamp=$(date +'%Y%m%d_%H%M%S')
screenshot_path="$HOME/Pictures/Screenshots/${timestamp}.png"

# Capture Region to File & Copy to Clipboard
grim -g "$(slurp -d)" "$screenshot_path"
wl-copy < "$screenshot_path"

# Desktop Notification
dunstify "Screenshot saved! as $screenshot_path" -i "$screenshot_path"
