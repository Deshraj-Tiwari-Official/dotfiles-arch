#!/bin/bash

RECORDINGS_DIR="$HOME/Videos/Recordings"
mkdir -p "$RECORDINGS_DIR"

# If already recording, send SIGINT to cleanly finalize the MP4 container
if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT -x wf-recorder
    dunstify "Screen Recording" "Saved to $RECORDINGS_DIR" -i video-x-generic
    exit 0
fi

# Select region
GEOM=$(slurp -d)
[ -z "$GEOM" ] && exit 1

# Detect default output device monitor (system sounds)
AUDIO_DEVICE="$(pactl get-default-sink).monitor"

OUTPUT_FILE="$RECORDINGS_DIR/recording_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

dunstify "Screen Recording" "Recording started (with desktop audio)..." -i media-record

# Record region and internal audio with AAC codec
wf-recorder \
    -g "$GEOM" \
    --audio="$AUDIO_DEVICE" \
    -C aac \
    -c libx264 \
    -p yuv420p \
    -f "$OUTPUT_FILE"
