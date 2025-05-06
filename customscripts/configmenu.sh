#!/usr/bin/env bash
# File: ~/.local/bin/config-editor-launcher.sh

# 1) Map menu entries to absolute paths
declare -A CONFIG_PATHS=(
  [bashrc]="$HOME/.bashrc"
  [zshrc]="$HOME/.zshrc"
  [gitconfig]="$HOME/.gitconfig"
  [kitty]="$HOME/.config/kitty/kitty.conf"
  [alacritty]="$HOME/.config/alacritty/alacritty.yml"
  [fish]="$HOME/.config/fish/config.fish"
  [nvim]="$HOME/.config/nvim/init.vim"
  [tmux]="$HOME/.tmux.conf"
  [starship]="$HOME/.config/starship.toml"
  [hypr]="$HOME/.config/hypr/hyprland.conf"
  [hyprpaper]="$HOME/.config/hypr/hyprpaper.conf"
  [waybar]="$HOME/.config/waybar/config"
  [picom]="$HOME/.config/picom/picom.conf"
  [rofi]="$HOME/.config/rofi/config.rasi"
  [wofi]="$HOME/.config/wofi/config"
  [dunst]="$HOME/.config/dunst/dunstrc"
)

# 2) Show menu and get choice
choice=$(printf "%s\n" "${!CONFIG_PATHS[@]}" \
         | wofi --show dmenu --prompt="Open config:")

# 3) If no choice, exit
[[ -z "$choice" ]] && exit 0

# 4) Resolve path and check
file="${CONFIG_PATHS[$choice]}"
if [[ ! -f "$file" ]]; then
  notify-send "Config Editor" "❌ File not found: $file"
  exit 1
fi

# 5) Open in VS Code
exec code "$file"
