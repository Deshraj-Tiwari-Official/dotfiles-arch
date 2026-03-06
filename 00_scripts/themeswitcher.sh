#!/bin/bash

# Directories
WALLPAPER_DIR="$HOME/dotfiles/backgrounds"
CACHE_FILE="$HOME/.cache/last_wallpaper"

shopt -s nullglob
wallpapers=("$WALLPAPER_DIR"/*)
shopt -u nullglob

if [[ ${#wallpapers[@]} -eq 0 ]]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

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

# 1. Apply the wallpaper using awww
awww img "$FULL_PATH" --transition-fps 30 --transition-type any --transition-duration 2

# 2. Generate color scheme with pywal
wal -q -i "$FULL_PATH" -n -s -t

# --- Cava Logic Integration ---
mkdir -p ~/.config/cava

# Source pywal's auto-generated bash script
if [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
    source "$HOME/.cache/wal/colors.sh"
else
    echo "Error: pywal colors.sh not found."
    exit 1
fi

# ATOMIC WRITE: Write Cava config to a temporary file first
cat <<EOF > ~/.config/cava/config.tmp
[color]
gradient = 1
gradient_count = 8
gradient_color_1 = '$color0'
gradient_color_2 = '$color1'
gradient_color_3 = '$color2'
gradient_color_4 = '$color3'
gradient_color_5 = '$color4'
gradient_color_6 = '$color5'
gradient_color_7 = '$color6'
gradient_color_8 = '$color7'
EOF

# Instantly swap the temp file in to replace the old config
mv ~/.config/cava/config.tmp ~/.config/cava/config

# ------------------------------

# 3. Save path to cache for persistence
echo "$FULL_PATH" > "$CACHE_FILE"

# 4. Reload Configs dynamically
# SIGUSR1 is the official Cava signal to reload the config without closing
killall -q -SIGUSR1 cava
killall -q -SIGUSR2 waybar
