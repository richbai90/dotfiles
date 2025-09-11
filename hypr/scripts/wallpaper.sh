#!/bin/bash

# Define the Wallhaven API URL with your search query.
API_URL="https://wallhaven.cc/api/v1/search?q=night+nature+photography&sorting=random&colors=663399"

# Define the directory where you want to save the wallpapers.
WALLPAPER_DIR="$HOME/.cache/hyprland/wallpapers"

# Ensure the wallpaper directory exists.
mkdir -p "$WALLPAPER_DIR"

# Get the JSON response from the Wallhaven API and extract a single random image URL.
WALLPAPER_URL=$(curl -s "$API_URL" | jq -r '.data[0].path')

# Get the filename from the URL.
FILENAME=$(basename "$WALLPAPER_URL")

# Define the full path for the new wallpaper.
WALLPAPER_PATH="$WALLPAPER_DIR/$FILENAME"

# Download the wallpaper to your cache directory.
wget -q -O "$WALLPAPER_PATH" "$WALLPAPER_URL"

# Check if the download was successful before changing the wallpaper.
if [ -f "$WALLPAPER_PATH" ]; then
    # Unload any old wallpapers to free up memory.
    hyprctl hyprpaper unload all
    
    # Preload the new wallpaper once.
    hyprctl hyprpaper preload "$WALLPAPER_PATH"

    # Get the names of all connected monitors using hyprctl and jq.
    # The '.[].name' filter extracts the 'name' field from every object in the JSON array.
    MONITORS=$(hyprctl monitors -j | jq -r '.[].name')

    # Loop through each monitor name and set the new wallpaper.
    for monitor in $MONITORS; do
        hyprctl hyprpaper wallpaper "$monitor,$WALLPAPER_PATH"
    done
    
    # Unload any wallpapers that are no longer being used.
    hyprctl hyprpaper unload unused
fi
