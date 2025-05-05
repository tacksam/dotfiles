#!/usr/bin/env bash
# File: ~/.local/bin/config-editor-launcher.sh
# Make sure this is executable: chmod +x ~/.local/bin/config-editor-launcher.sh

# 1) List of choices (you can also generate this by scanning a directory)
declare -A CONFIG_PATHS=(
  [kitty]="~/.config/kitty/kitty.conf"
  [fish]="~/.config/fish/config.fish"
  [hypr]="~/.config/hypr/hyprland.conf"
  [hyprpaper]="~/.config/hyprpaper/config.json"
  # add more entries here...
)

# 2) Show wofi menu and capture the key
choice=$(printf "%s\n" "${!CONFIG_PATHS[@]}" \
         | wofi --dmenu --prompt="Open config:")

# 3) If no choice was made, just exit
if [[ -z "$choice" ]]; then
  exit 0
fi

# 4) Resolve the path and open in your terminal/editor
file="${CONFIG_PATHS[$choice]}"
# Expand tilde:
file="${file/#\~/$HOME}"

# Here we launch your terminal (kitty) running your editor (e.g. nvim)
# You could swap to kombinations like: kitty -e fish -c "nvim $file"
exec kitty -- bash -lc "nvim $file"
