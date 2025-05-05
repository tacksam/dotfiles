#!/usr/bin/env bash
# Config launcher via wofi → opens in nvim inside your terminal emulator

# ─── 1) Force sensible defaults ──────────────────────
: "${EDITOR:=nvim}"           # if $EDITOR isn’t set, use nvim
: "${TERMINAL:=kitty}"        # change to alacritty/gnome-terminal/etc as you prefer

# ─── 2) Map names → config files ────────────────────
declare -A cfg=(
  [hypr]="$HOME/.config/hypr/hyprland.conf"
  [fish]="$HOME/.config/fish/config.fish"
  [kitty]="$HOME/.config/kitty/kitty.conf"
  [alacritty]="$HOME/.config/alacritty/alacritty.yml"
  [nvim]="$HOME/.config/nvim/init.vim"
  [waybar]="$HOME/.config/waybar/config"
  [wofi]="$HOME/.config/wofi/config"
  [rofi]="$HOME/.config/rofi/config.rasi"
  [picom]="$HOME/.config/picom/picom.conf"
)

# ─── 3) Ask the user which one to edit ──────────────
choice=$(printf '%s\n' "${!cfg[@]}" \
         | wofi --show dmenu --prompt "Edit config:")

# if they hit Esc or close it, just quit
[[ -z "$choice" ]] && exit 0

file="${cfg[$choice]}"

# ─── 4) Sanity‐check the file exists ─────────────────
if [[ ! -f "$file" ]]; then
  notify-send "Config Launcher" "❌ File not found: $file"
  exit 1
fi

# ─── 5) Launch nvim INSIDE your terminal ────────────
# the & makes the launcher return immediately
"$TERMINAL" -e "$EDITOR" "$file" &

exit 0
