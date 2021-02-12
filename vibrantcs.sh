#!/bin/bash

PRIMARY_MONITOR="DP-0"
DEFAULT_VIBRANCE=0
CSGO_DESIRED_VIBRANCE=800

# Wait for our baseline to come in for comparisons
# This is important only if the server is enabled to start on boot
until ! [ -z "$current_vibrance" ]; do
    current_vibrance=$(nvidia-settings -c :0 --query [gpu:0]/DigitalVibrance[DP-0] | grep "DigitalVibrance" | head -n 1 | awk '{print $NF}' | cut -d '.' -f1)
done

while true; do
    if pgrep -x "csgo_linux64" > /dev/null; then
        if [ $current_vibrance -ne $CSGO_DESIRED_VIBRANCE ]; then
            #notify-send "Turning On: Digital Vibrance set to '${CSGO_DESIRED_VIBRANCE:-N/A}'" --app-name="VibrantCS"
            echo "CSGO instance detected. Setting Digital Vibrance to '${CSGO_DESIRED_VIBRANCE}'"
            nvidia-settings -c :0 -a [gpu:0]/DigitalVibrance[$PRIMARY_MONITOR]=${CSGO_DESIRED_VIBRANCE} > /dev/null
            current_vibrance=${CSGO_DESIRED_VIBRANCE}
        fi
    else
        if [ $current_vibrance -ne $DEFAULT_VIBRANCE ]; then
            #notify-send "Turning Off: Digital Vibrance set to '${DEFAULT_VIBRANCE:-N/A}'" --app-name="VibrantCS"
            echo "CSGO no longer running. Setting Digital Vibrance to '${DEFAULT_VIBRANCE}'"
            nvidia-settings -c :0 -a [gpu:0]/DigitalVibrance[$PRIMARY_MONITOR]=${DEFAULT_VIBRANCE} > /dev/null
            current_vibrance=${DEFAULT_VIBRANCE}
        fi
    fi
done
