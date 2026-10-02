#!/usr/bin/env bash

TERM_CMD="kitty"

declare -A APP_MAP
declare -A ICON_MAP
desktop_entries=""

# Search standard desktop entry directories
for dir in "$HOME/.local/share/applications" "/usr/local/share/applications" "/usr/share/applications"; do
    [ -d "$dir" ] || continue
    for file in "$dir"/*.desktop; do
        [ -r "$file" ] || continue

        grep -q "^NoDisplay=true" "$file" 2>/dev/null && continue
        grep -q "^Hidden=true" "$file" 2>/dev/null && continue

        name=$(grep -m 1 "^Name=" "$file" | cut -d'=' -f2-)
        exec_cmd=$(grep -m 1 "^Exec=" "$file" | cut -d'=' -f2- | sed -E 's/%[uUfFdiDnNvmk]//g')
        icon=$(grep -m 1 "^Icon=" "$file" | cut -d'=' -f2-)
        is_terminal=$(grep -m 1 "^Terminal=" "$file" | cut -d'=' -f2-)

        if [ -n "$name" ] && [ -n "$exec_cmd" ]; then
            if [ "$is_terminal" = "true" ]; then
                exec_cmd="$TERM_CMD $exec_cmd"
            fi

            if [ -z "${APP_MAP["$name"]}" ]; then
                APP_MAP["$name"]="$exec_cmd"
                ICON_MAP["$name"]="${icon:-application-x-executable}"
                desktop_entries+="$name"$'\n'
            fi
        fi
    done
done

# Stream custom utilities and desktop apps directly to Rofi
selected=$(
    {
        # Utility entries: "DisplayName\0icon\x1fIconName\n"
        printf "Network Manager (nmtui)\0icon\x1fnetwork-wireless\n"
        printf "Bluetooth (bluetuith)\0icon\x1fbluetooth\n"

        # Alphabetized desktop entries
        while IFS= read -r app_name; do
            [ -z "$app_name" ] && continue
            printf "%s\0icon\x1f%s\n" "$app_name" "${ICON_MAP["$app_name"]}"
        done < <(printf '%s' "$desktop_entries" | sort -u)
    } | rofi -dmenu -i -matching fuzzy -p "Launcher" -show-icons
)

[ -z "$selected" ] && exit 0

# Execute selection
case "$selected" in
    "Network Manager (nmtui)")
        $TERM_CMD nmtui & ;;
    "Bluetooth (bluetuith)")
        $TERM_CMD bluetuith & ;;
    *)
        if [ -n "${APP_MAP["$selected"]}" ]; then
            nohup bash -c "${APP_MAP["$selected"]}" >/dev/null 2>&1 &
        fi
        ;;
esac
