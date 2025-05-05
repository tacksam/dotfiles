#!/usr/bin/env bash

# Directory containing your wallpapers
WALLDIR="$HOME/Pictures/Wallpapers"

# Pick one at random
WALL="$(find "$WALLDIR" -type f | shuf -n1)"

# Preload and apply to all monitors
hyprctl hyprpaper preload "$WALL"
hyprctl hyprpaper wallpaper ",$WALL"

# Unload any others to free RAM
hyprctl hyprpaper unload all
