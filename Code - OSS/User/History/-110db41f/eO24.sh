#!/usr/bin/env bash
# File: ~/.local/bin/config-editor-launcher.sh
# Make sure this is executable:
#   chmod +x ~/.local/bin/config-editor-launcher.sh

# 1) List of choices → config files
declare -A CONFIG_PATHS=(
  [bashrc]="~/.bashrc"
  [zshrc]="~/.zshrc"
  [gitconfig]="~/.gitconfig"
  [kitty]="~/.config/kitty/kitty.conf"
  [alacritty]="~/.config/alacritty/alacritty.yml"
  [fish]="~/.config/fish/config.fish"
  [nvim]="~/.config/nvim/init.vim"
  [tmux]="~/.tmux.conf"
  [starship]="~/.config/starship.toml"
  [hypr]="~/.config/hypr/hyprland.conf"
  [hyprpaper]="~/.config/hyprpaper/config.json"
  [waybar]="~/.config/waybar/config"
  [picom]="~/.config/picom/picom.conf"
  [rofi]="~/.config/rofi/config.rasi"
  [wofi]="~/.config/wofi/config"
  [sway]="~/.config/sway/config"
  [polybar]="~/.config/polybar/config.ini"
  # add more entries as desired…
)

# 2) Show wofi menu and capture the key
choice=$(printf "%s\n" "${!CONFIG_PATHS[@]}" \
         | wofi --dmenu --prompt="Open config:")

# 3) If cancelled, exit
[[ -z "$choice" ]] && exit 0

# 4) Resolve the chosen file path
file="${CONFIG_PATHS[$choice]}"
file="${file/#\~/$HOME}"   # expand leading ~

# 5) Verify it exists
if [[ ! -f "$file" ]]; then
  notify-send "Config Editor" "❌ File not found: $file"
  exit 1
fi

# 6) Launch in kitty → nvim
exec kitty -- bash -lc "nvim '$file'"
