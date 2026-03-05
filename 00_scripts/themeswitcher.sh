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

# 1. Apply the wallpaper using swww
swww img "$FULL_PATH" --transition-fps 30 --transition-type any --transition-duration 2

# 2. Generate color scheme with pywal
wal -q -i "$FULL_PATH" -n -s -t

# 3. Save path to cache for persistence
echo "$FULL_PATH" > "$CACHE_FILE"

# 4. Reload Configs to apply new CSS colors
killall -SIGUSR2 waybar
