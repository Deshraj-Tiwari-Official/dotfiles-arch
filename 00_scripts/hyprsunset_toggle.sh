#!/usr/bin/env bash

# State file to track whether warm mode is currently active
STATE_FILE="/tmp/hyprsunset_state"
WARM_TEMP=3000

if [ -f "$STATE_FILE" ]; then
    # Currently warm -> restore normal screen
    hyprctl hyprsunset identity
    rm -f "$STATE_FILE"
else
    # Currently normal -> set warm temperature
    hyprctl hyprsunset temperature "$WARM_TEMP"
    touch "$STATE_FILE"
fi
