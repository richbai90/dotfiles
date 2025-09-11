#!/bin/sh

# Check if a Spotify window exists by looking for its WM_CLASS ("Spotify")
WORKSPACE_ID=$(hyprctl clients -j | jq -r '.[] | select(.class=="Spotify") | .workspace.id' | head -n 1)

if [ -n "$WORKSPACE_ID" ]; then
    # If a workspace ID was found, switch to that workspace
    hyprctl dispatch workspace "$WORKSPACE_ID"
else
    # If no Spotify window was found, launch Spotify
    # The '&' runs it in the background, so it doesn't block the script
    spotify &
fi
