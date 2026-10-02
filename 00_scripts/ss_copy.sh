#!/bin/bash

# Create Temporary File
temp_file=$(mktemp --suffix=.png)

# Capture Region & Copy to Wayland Clipboard
grim -g "$(slurp -d)" "$temp_file"
wl-copy < "$temp_file"

# Desktop Notification & Cleanup
dunstify "Screenshot copied!" "The screenshot has been copied to your clipboard" -i "$temp_file"
rm "$temp_file"
