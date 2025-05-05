#!/usr/bin/env bash
export EDITOR="${EDITOR:-nvim}"
# ───────────────────────────────────────────────────────
# Config launcher via wofi → opens in $EDITOR (default nvim)
# ───────────────────────────────────────────────────────

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

choice=$(printf '%s\n' "${!cfg[@]}" \
         | wofi --show dmenu --prompt "Edit config:")

[[ -z "$choice" ]] && exit 0

$EDITOR "${cfg[$choice]}"
