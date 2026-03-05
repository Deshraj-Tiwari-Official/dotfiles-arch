#!/bin/bash

# Directories
WALLPAPER_DIR="$HOME/dotfiles/backgrounds"
CACHE_FILE="$HOME/.cache/last_wallpaper"

# 1. Define the Rofi grid theme
# This is placed here so it can be passed to the variable function below
ROFI_THEME='
@import "~/.cache/wal/colors-rofi-dark.rasi"

* {
    background-color: transparent;
}

window {
    width: 800px;
    height: 600px;
    border: 1px;
    background-color: @background;
    padding: 20px;
}

mainbox {
    spacing: 15px;
    children: [ inputbar, listview ];
}

inputbar {
    spacing: 10px;
    padding: 10px;
    background-color: @background;
    border: 1px;
    children: [ prompt, entry ];
}

prompt {
    font: "bold";
}

entry {
    placeholder: "Search wallpapers...";
}

listview {
    columns: 4;
    lines: 3;
    spacing: 15px;
    cycle: true;
    dynamic: true;
    layout: vertical;
}

element {
    orientation: vertical;
    padding: 10px;
    background-color: transparent;
}

element selected {
    background-color: @selected-normal-background;
}

element-icon {
    size: 177px;
    horizontal-align: 0.5;
    background-color: transparent;
}

element-text {
    horizontal-align: 0.5;
    vertical-align: 0.5;
    background-color: transparent;
    margin: 5px 0px 0px 0px;
}
'

# 2. Open Rofi and select wallpaper
# Generates list with icons and pipes directly to rofi to avoid "ghost" entries
SELECTED=$(
    for pic in "$WALLPAPER_DIR"/*; do
        if [[ -f "$pic" ]]; then
            echo -en "$(basename "$pic")\0icon\x1f${pic}\n"
        fi
    done | rofi -dmenu -i -p "󰸉 " -show-icons -theme-str "$ROFI_THEME"
)

# Exit if nothing was selected (user pressed Esc)
if [[ -z "$SELECTED" ]]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_DIR/$SELECTED"

# 3. Apply the wallpaper using swww
swww img "$FULL_PATH" --transition-fps 30 --transition-type any --transition-duration 2

# 4. Generate color scheme with pywal
wal -q -i "$FULL_PATH" -n -s -t

# 5. Save path to cache for persistence
echo "$FULL_PATH" > "$CACHE_FILE"

# 6. Reload Configs to apply new CSS colors
killall -SIGUSR2 waybar
