#!/bin/bash

# Directory & State Paths
WALLPAPER_DIR="$HOME/dotfiles/backgrounds"
CACHE_FILE="$HOME/.cache/last_wallpaper"

# Wallpaper Discovery & Indexing
shopt -s nullglob
wallpapers=("$WALLPAPER_DIR"/*)
shopt -u nullglob

if [[ ${#wallpapers[@]} -eq 0 ]]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Next Wallpaper Selection (Cyclic)
if [[ -f "$CACHE_FILE" ]]; then
    LAST_WALLPAPER=$(cat "$CACHE_FILE")
else
    LAST_WALLPAPER=""
fi

NEXT_INDEX=0
for i in "${!wallpapers[@]}"; do
    if [[ "${wallpapers[$i]}" == "$LAST_WALLPAPER" ]]; then
        NEXT_INDEX=$((i + 1))
        break
    fi
done

if [[ $NEXT_INDEX -ge ${#wallpapers[@]} ]]; then
    NEXT_INDEX=0
fi
FULL_PATH="${wallpapers[$NEXT_INDEX]}"

# Wallpaper Application (awww)
awww img "$FULL_PATH" --transition-fps 30 --transition-type any --transition-duration 1.2

# Color Palette Generation (pywal)
wal -q -i "$FULL_PATH" -n -s -t

# Audio Visualizer Theming (Cava)
mkdir -p ~/.config/cava

# Source pywal colors
if [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
    source "$HOME/.cache/wal/colors.sh"
else
    echo "Error: pywal colors.sh not found."
    exit 1
fi

# Atomic write for Cava gradient configuration
cat <<EOF > ~/.config/cava/config.tmp
[color]
gradient = 1
gradient_count = 8
gradient_color_1 = '$color0'
gradient_color_2 = '$color1'
gradient_color_3 = '$color2'
gradient_color_4 = '$color3'
gradient_color_5 = '$color4'
gradient_color_5 = '$color4'
gradient_color_6 = '$color5'
gradient_color_7 = '$color6'
gradient_color_8 = '$color7'
EOF

mv ~/.config/cava/config.tmp ~/.config/cava/config

# Persistence Cache Update
echo "$FULL_PATH" > "$CACHE_FILE"

# Dynamic Service & UI Reloads
# Live reload Cava and Waybar without restarting processes
killall -q -SIGUSR1 cava
killall -q -SIGUSR2 waybar

# Relaunch active Rofi instance with updated colors if currently visible
if pgrep -x rofi >/dev/null && [[ -f /tmp/active_rofi_menu ]]; then
    ACTIVE_SCRIPT=$(cat /tmp/active_rofi_menu)
    killall -q rofi
    sleep 0.1
    bash "$ACTIVE_SCRIPT" &
fi
