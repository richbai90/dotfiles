#!/bin/bash

# Path to your SQLite database
DB_PATH="$HOME/.config/hypr/layouts.db"

# The desired layout is the first argument to the script (e.g., "master")
NEW_LAYOUT=$1

if [ -z "$NEW_LAYOUT" ]; then
  echo "Usage: $0 <layout_name>"
  exit 1
fi

# Get the ID of the currently active workspace
ACTIVE_WORKSPACE_ID=$(hyprctl activeworkspace -j | jq -r '.id')

# Update the database. "INSERT OR REPLACE" is perfect for this.
# It will create a new row if the ID doesn't exist, or update the existing one.
sqlite3 "$DB_PATH" \
  "INSERT OR REPLACE INTO workspaces (id, layout) VALUES ($ACTIVE_WORKSPACE_ID, '$NEW_LAYOUT');"

# Apply the new layout immediately so the user sees the change
hyprctl keyword general:layout "$NEW_LAYOUT"
