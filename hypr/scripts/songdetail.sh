#!/bin/bash

if playerctl metadata --format '{{mpris:trackid}}' | grep -q 'com/spotify'; then
    icon=""  # Spotify is running
else
    icon="󰗃"  # Spotify is not running or another player is active
fi
song_info=$(playerctl metadata --format "{{title}}  $icon    {{artist}}")

echo "$song_info" 
