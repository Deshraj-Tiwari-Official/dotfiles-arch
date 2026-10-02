#!/bin/bash

# State Tracking & Cleanup
echo "$HOME/dotfiles/00_scripts/rofi_themeswitcher.sh" > /tmp/active_rofi_menu
trap 'rm -f /tmp/active_rofi_menu' EXIT

# Configuration & Asset Paths
WALLPAPER_DIR="$HOME/dotfiles/backgrounds"
CACHE_FILE="$HOME/.cache/last_wallpaper"
ROFI_THEME="$HOME/.config/rofi/wallpaper_grid.rasi"

# Wallpaper Discovery & Validation
shopt -s nullglob
wallpapers=("$WALLPAPER_DIR"/*.{png,jpg,jpeg,webp,PNG,JPG,JPEG,WEBP})
shopt -u nullglob

if [[ ${#wallpapers[@]} -eq 0 ]]; then
    notify-send "Themeswitcher" "No images found in $WALLPAPER_DIR"
    exit 1
fi

# Build Menu Entries with Thumbnail Icons
entries=""
for wp in "${wallpapers[@]}"; do
    name=$(basename "$wp")
    entries+="${name}\0icon\x1f${wp}\n"
done

# Launch Rofi Selector (Interactive Filtering)
selected=$(printf "%b" "$entries" | rofi -dmenu -theme "$ROFI_THEME" -i)

# Exit if user cancelled (Esc or clicked outside)
[[ -z "$selected" ]] && exit 0

FULL_PATH="$WALLPAPER_DIR/$selected"

if [[ ! -f "$FULL_PATH" ]]; then
    exit 1
fi

# Apply Wallpaper (awww) & Generate Palette (pywal)
awww img "$FULL_PATH" --transition-fps 30 --transition-type any --transition-duration 1.2
wal -q -i "$FULL_PATH" -n -s -t

# Update Audio Visualizer Gradient (Cava)
mkdir -p ~/.config/cava
if [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
    source "$HOME/.cache/wal/colors.sh"
else
    echo "Error: pywal colors.sh not found."
    exit 1
fi

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

mv ~/.config/cava/config.tmp ~/.config/cava/config

# Persist Cache & Reload Dynamic Services
echo "$FULL_PATH" > "$CACHE_FILE"

# Live reload Cava and Waybar without restarting processes
killall -q -SIGUSR1 cava
killall -q -SIGUSR2 waybar
