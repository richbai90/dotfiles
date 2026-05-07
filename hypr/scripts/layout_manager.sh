#!/bin/bash

# Path to your SQLite database
DB_PATH="$HOME/.config/hypr/layouts.db"
DEFAULT_LAYOUT="dwindle"

handle() {
  if [[ ${1:0:9} == "workspace" ]]; then
    WORKSPACE_ID=$(echo "$1" | sed -e 's/workspace>>//')

    # Query the database for the layout associated with this workspace ID
    SAVED_LAYOUT=$(sqlite3 "$DB_PATH" "SELECT layout FROM workspaces WHERE id = $WORKSPACE_ID;")

    # If the query returns an empty string, use the default layout.
    # Otherwise, use the layout we found in the database.
    if [ -z "$SAVED_LAYOUT" ]; then
      hyprctl keyword general:layout "$DEFAULT_LAYOUT"
    else
      hyprctl keyword general:layout "$SAVED_LAYOUT"
    fi
  fi
}

socat -u "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do
  handle "$line"
done
